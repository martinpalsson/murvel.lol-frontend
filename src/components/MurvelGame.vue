<template>
    <div>
        <p class="generatedText">{{ textRepresentation }} {{ shownState }}</p>
    </div>
</template>

<script>
    import axios from 'axios'
    import { ref, computed, onUnmounted } from 'vue'

    export default {
        name: 'MurvelGame',
        components: {
        },
        props: {
            category: String,
        },
        async setup(props) {
            /* Data */
            const sentence = ref([])
            const possibleStates = ref([])
            const shownState = ref("")
            const timer = ref(null)
            const triesLeft = ref(Number)
            
            /* last word in sentence */
            const lastWordInSentence = computed(() => {
                if (sentence.value.length > 0) {
                    return sentence.value[sentence.value.length - 1]
                } else {
                    return ""
                }
            })
            
            /* textual representation of sentence */
            const textRepresentation = computed(() => {
                if (sentence.value.length > 0){
                    return sentence.value.join(" ")
                } else {
                    return ""
                }
            })

            async function getFirstState(cat) {
                const startStates = await axios.get(
                `https://api.murvel.lol/lookup/${cat}`
                )
                return startStates.data.next_states[
                    Math.floor(Math.random()*startStates.data.next_states.length)
                ]
            }

            async function getPossibleStates(cat, sta) {
                const nextStates = await axios.get(
                `https://api.murvel.lol/lookup/${cat}`, {params: { state: `${sta}` }}
                )
                return nextStates.data.next_states
            }
            
            function startTimer() {
                /* Set interval of timer */
                
                timer.value = setInterval(() => {
                    /* Timer has not reached the end, randomize state */
                    if (triesLeft.value > 0) {
                        /* Randomize state */
                        shownState.value = possibleStates.value[
                            Math.floor(Math.random()*possibleStates.value.length)
                        ]
                        /* decrement tries */
                        triesLeft.value--
                    } else {
                        /* Timer has reached the end, push state to sentence */
                        pushWord(shownState.value)
                    }
                
                }, 50)
            }

            function stopTimer() {
                clearInterval(timer.value)
            }

            function getMaxTries(nStates) {
                if (nStates < 5) {
                    return nStates
                } else {
                    return 5
                }
            }

           async function pushWord(data) {
                
                if(data != "" && data != undefined) {
                    /* Pause the timer */
                    stopTimer()
                    /* Get the next states */
                    possibleStates.value = await getPossibleStates(props.category, data)
                    /* calculate number of tries */
                    triesLeft.value = getMaxTries(possibleStates.value.length)
                    /* Push selected state to sentence */
                    sentence.value.push(data)
                    /* Randomize next shown state */
                    shownState.value = possibleStates.value[
                                Math.floor(Math.random()*possibleStates.value.length)
                            ]
                    /* Start timer again */
                    startTimer()
                } else {
                    /* Has reached the end of the sentence */
                    stopTimer()
                }
            }

            onUnmounted(() => stopTimer())

            /* Setup logic */
            /* get start word */
            const firstWord = await getFirstState(props.category)
            sentence.value.push(firstWord)
            /* get possible next states */
            possibleStates.value = await getPossibleStates(props.category, firstWord)
            /* calculates number of tries */
            triesLeft.value = getMaxTries(possibleStates.value.length)
            /* start timer */
            startTimer()

            return {
                /* exposed data */
                shownState : shownState,
                /* computed */
                textRepresentation: textRepresentation,
            }
        },
    }
</script>

<style scoped>
    .generatedText {
        line-height: 150%;
    }
</style>