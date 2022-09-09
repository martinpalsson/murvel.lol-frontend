<template>
    <li @click="pushWord">{{ text }}</li>
</template>

<script>
    export default {
        name: "Word",
        props: {
            text: String,
        },
        data() {
            return {

            }
        },
        methods: {
            pushWord(){
                this.$emit('pushWord', this.text)
            }
        }
    }
</script>