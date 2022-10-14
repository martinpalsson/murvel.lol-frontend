<template>
<div>
    <div class="container px-4 pt-2 bg-white/50 flex flex-col h-96">
        <!-- Generated text -->
        <div class="h-full overflow-y-auto">
            <p class="leading-normal font-inconsolata text-md font-light text-start hover:text-blue-700 hover:underline">
                {{ textRepresentation }} {{ shownState }}
            </p>
        </div>
    </div>
</div>

<div class="container  bg-white/50 flex flex-row justify-end">
    <div
        class="w-1/3 flex justify-center rounded-l-full bg-white hover:bg-amber-50 hover:cursor-pointer py-2"
        @click="resetButtonCB"
        >
        <vueFeather type="refresh-cw" size="16" />
    </div>
</div>
</template>

<script>
    import axios from 'axios'
    import { ref, computed, onUnmounted } from 'vue'

    export default {
        name: 'MurvelRobot',
        components: {
        },
        props: {
            category: String,
            reset: Boolean,
        },
        async setup(props) {
            /* Data */
            const sentence = ref([])
            const possibleStates = ref([])
            const shownState = ref("")
            const FSMtimer = ref(null)
            const robotState = ref("init")
            const triesLeft = ref(Number)
            const resetButton = ref(Boolean)
            const sampledCategory = ref("")

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

            /* only blanks in possibleStates? */
            const isOnlyEndWords = computed(() => {
                return possibleStates.value.join("").trim().length == 0                
            })

            async function getFirstState(cat) {
                const startStates = await axios.get(
                `https://api.murvel.lol/lookup/${cat}`
                )
                return startStates.data.next_states[
                    Math.floor(Math.random()*startStates.data.next_states.length)
                ]
            }

            async function getPossibleStates(cat, sta, psta) {
                const nextStates = await axios.get(
                `https://api.murvel.lol/lookup/${cat}`, {params: { state: `${sta}`, prevState: `${psta}`}}
                )
                return nextStates.data.next_states
            }

            function startTimer() {
                /* Set interval of timer */

                FSMtimer.value = setInterval(() => {
                    runFSM()
                }, 50)
            }

            function stopTimer() {
                clearInterval(FSMtimer.value)
            }

            async function runFSM() {
            /* mermaid diagram
            stateDiagram-v2
            [*] --> ResetRobot

            ResetRobot --> StartRobot

            StartRobot --> FetchData
            LoopThrough --> FetchData
            FetchData --> LoopThrough

            FetchData --> Idle

            LoopThrough --> ResetRobot
            FetchData --> ResetRobot
            Idle --> ResetRobot
            */
            
                /* init: Just start timer for FSM */
                if (robotState.value === "init") {
                    robotState.value        = "reset"
                /* reset: Reset variables */
                } else if (robotState.value === "reset") {
                    stopTimer()
                    sentence.value          = []
                    possibleStates.value    = []
                    shownState.value        = ""
                    FSMtimer.value          = null
                    triesLeft.value         = 0
                    resetButton.value       = false
                    sampledCategory.value   = props.category
                    /* Next state: start */
                    robotState.value        = "start"
                    startTimer()
                /* start: Get the first word */
                } else if (robotState.value === "start") {
                    stopTimer()
                    /* get start word */
                    const firstWord         = await getFirstState(sampledCategory.value)
                    sentence.value.push(firstWord)
                    /* get possible next states */
                    possibleStates.value    = await getPossibleStates(sampledCategory.value, firstWord)
                    /* calculates number of tries */
                    triesLeft.value = getMaxTries(possibleStates.value.length)
                    /* Next state: loop */
                    robotState.value        = "loop"
                    /* start timer */
                    startTimer()
                /* loop: loop through possible states */
                } else if (robotState.value === "loop") {
                    stopTimer()
                    if (triesLeft.value > 0) {
                        /* Randomize state */
                        shownState.value = possibleStates.value[
                            Math.floor(Math.random()*possibleStates.value.length)
                        ]
                        /* decrement tries */
                        triesLeft.value--
                    } else {
                        /* Timer has reached the end, next state fetch */
                        /* TODO: Retry for short sentences gets stuck */
                        /* Doesn't catch cases where all possible states are "", */
                        /* The computed value isOnlyEndWords doesn't work, now inverted */
                        /* At least it doesn't print any more text.. */
                        if (isOnlyEndWords && shownState.value === "" && sentence.value.length < 10) {
                            triesLeft.value = 5
                        } else {
                            robotState.value        = "fetch"
                        }

                    }

                    if (resetButton.value == true) {
                        /* Reset button was clicked */
                        robotState.value        = "reset"
                    }

                    startTimer()
                } else if (robotState.value === "fetch") {
                    stopTimer()
                    const data = shownState.value
                    if(data != "" && data != undefined) {
                        /* Get the next states */
                        possibleStates.value = await getPossibleStates(
                            sampledCategory.value,
                            data,
                            sentence.value[sentence.value.length - 1]
                            )
                        /* calculate number of tries */
                        triesLeft.value = getMaxTries(possibleStates.value.length)
                        /* Push selected state to sentence */
                        sentence.value.push(data)
                        /* Randomize next shown state */
                        shownState.value = possibleStates.value[
                            Math.floor(Math.random()*possibleStates.value.length)
                        ]
                        /* New data fetched, next state loop */
                        robotState.value        = "loop"
                    } else {
                        /* Reched end of sentence, next state idle */
                        robotState.value        = "idle"
                    }

                    if (resetButton.value == true) {
                        /* Reset button was clicked */
                        robotState.value        = "reset"
                    }

                    startTimer()
                } else if (robotState.value === "idle") {
                    if (resetButton.value == true) {
                        /* Reset button was clicked */
                        robotState.value        = "reset"
                    }
                } else {
                    console.error("Erroneous state")
                }
            }

            function getMaxTries(nStates) {
                if (nStates < 5) {
                    return nStates
                } else {
                    return 5
                }
            }

            function resetButtonCB() {
                resetButton.value = true
            }

            onUnmounted(() => stopTimer())

            startTimer()

            return {
                /* exposed data */
                shownState : shownState,
                /* computed */
                textRepresentation: textRepresentation,
                /* callbacks */
                resetButtonCB: resetButtonCB,
            }
        },
    }
</script>