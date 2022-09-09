<template>
    <div>
        <p class="generatedText"><strong>{{ textRepresentation }} {{ shownState }}</strong></p>
    </div>
</template>

<script>
    import axios from 'axios'
    import { useKeypress } from 'vue3-keypress'

    export default {
        name: 'WordGame',
        components: {
        },
        props: {
            category: String,
        },
        data() {
            return {
            sentence: [],
            possible_states: [""],
            shownState: "",
            timer: null,
            tries_left: Number,
            }
        },
        async beforeCreate() {
            this.shownState = ""
            const startWordResponse = await axios.get(`http://localhost:8000/lookup/${this.category}`)
            const startWord = startWordResponse.data.next_states[
                Math.floor(Math.random()*startWordResponse.data.next_states.length)
            ]
            const nextStates = await axios.get(`http://localhost:8000/lookup/${this.category}?state=${startWord}`)
            this.sentence.push(startWord)
            this.possible_states=nextStates.data.next_states
            this.shownState = this.possible_states[
                Math.floor(Math.random()*this.possible_states.length)
            ]
            // same as possible_states.length but max 5
            if (this.possible_states.length < 5) {
                this.tries_left = this.possible_states.length
            }
            else {
                this.tries_left = 5
            }
            this.startTimer()
        },
        created() {
            
        },
        mounted() {
            // this.startTimer()
        },
        beforeUnmount() {
            this.stopTimer()
        },
        methods: {
            async pushWord(data) {
                
                if(data != "" && data != undefined) {

                    this.stopTimer()
                    const nextStates = await axios.get(`http://localhost:8000/lookup/${this.category}?state=${data}`)
                    this.possible_states=nextStates.data.next_states
                    this.tries_left = 5
                    this.sentence.push(data)
                    this.shownState = this.possible_states[
                                Math.floor(Math.random()*this.possible_states.length)
                            ]
                    this.startTimer()
                } else {
                    // Finish sentence.
                    this.stopTimer()
                }
                

            },
            startTimer() {
                this.timer = setInterval(() => {
                    if (this.tries_left > 0) {
                        this.shownState = this.possible_states[
                            Math.floor(Math.random()*this.possible_states.length)
                        ]
                        this.tries_left--
                    } else {
                        this.pushWord(this.shownState)
                    }
                
                }, 50)
            },
            stopTimer() {
                clearInterval(this.timer)
            },
            refreshTimer() {
                this.stopTimer()
                this.startTimer()
            }
        },
        computed: {
            lastWordInSentence() {
                if (this.sentence.length > 0)
                {
                    return this.sentence[this.sentence.length - 1]
                }
                else
                {
                    return ""
                }
                
            },
            textRepresentation() {
                if (this.sentence.length > 0)
                {
                    return this.sentence.join(" ")
                }
                else
                {
                    return ""
                }
                
            },
            triesLeftString() {
                return `${this.tries}`
            }
        },
    }
</script>

<style scoped>
    .generatedText {
        line-height: 150%;
    }
</style>