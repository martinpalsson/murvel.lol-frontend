<template>


</template>

<script>
    import { ref } from 'vue'
    import axios from 'axios'

    export default {
        name: 'WordGameComp',
        props: {

        },
        components: {
            
        },
        setup(props, context) {
            const sentence = ref([])
            const possibleStates = ref([])
            const shownState = ref("")

            const async getFirstWord = () => {
                const startWordResponse = await axios.get('http://localhost:8000/lookup/All')
                const startWord = startWordResponse.data.next_states[
                    Math.floor(Math.random()*startWordResponse.data.next_states.length)
                ]
            }

            


            return {
                sentence,
                possibleStates,


            }
        },
        onMounted() {

        },
        onBeforeUnmount() {

        }
    }
</script>