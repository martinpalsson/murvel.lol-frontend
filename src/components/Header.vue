<template>
    <header>
        <h1 class="title">{{ title }}</h1>
    </header>
</template>

<script>
    
    export default {
        name: 'Header',
        props: {
            title: String,
        },
        components: {
            
        }
    }
</script>

<style scoped>
    .title {
        font-family: 'Inconsolata-400';
        font-size:xx-large;
    }
</style>