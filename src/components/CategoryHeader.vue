<template>
    <header>
        <span class="category">{{category}}</span>
        <hr />
    </header>
</template>

<script>
    
    export default {
        name: 'Header',
        props: {
            category: String,
        },
        components: {
            
        }
    }
</script>

<style scoped>
    .title {
        font-size:xx-small;
    }
</style>