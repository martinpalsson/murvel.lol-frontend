<template>

  <div class="container">
    <div class="row">
      <div class="col-md-6 col-lg-5  col-xl-4 col-xxl-3 mx-auto">
        <div class="box">
          <Header title="murvel.lol" />
          <CategoryHeader category="BLANDAT" />
          <WordGame category="All"/>
        </div> 
      </div>
    </div>
  </div>
</template>

<script>
import Header from './components/Header.vue'
import CategoryHeader from './components/CategoryHeader.vue'
import WordGame from './components/WordGame.vue'

export default {

  name: 'App',
  components: {
    Header,
    CategoryHeader,
    WordGame,
}
}
</script>

<style>
  /* inconsolata-regular 700 weight - latin */
  @font-face {
    font-family: 'Inconsolata-700';
    font-style: normal;
    font-weight: 700;
    src: url('../fonts/inconsolata-v31-latin-regular.eot'); /* IE9 Compat Modes */
    src: local(''),
        url('../fonts/inconsolata-v31-latin-regular.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
        url('../fonts/inconsolata-v31-latin-regular.woff2') format('woff2'), /* Super Modern Browsers */
        url('../fonts/inconsolata-v31-latin-regular.woff') format('woff'), /* Modern Browsers */
        url('../fonts/inconsolata-v31-latin-regular.ttf') format('truetype'), /* Safari, Android, iOS */
        url('../fonts/inconsolata-v31-latin-regular.svg#Inconsolata') format('svg'); /* Legacy iOS */
  }

   /* inconsolata-regular 700 weight - latin */
   @font-face {
    font-family: 'Inconsolata-400';
    font-style: bold;
    font-weight: 400;
    src: url('../fonts/inconsolata-v31-latin-regular.eot'); /* IE9 Compat Modes */
    src: local(''),
        url('../fonts/inconsolata-v31-latin-regular.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
        url('../fonts/inconsolata-v31-latin-regular.woff2') format('woff2'), /* Super Modern Browsers */
        url('../fonts/inconsolata-v31-latin-regular.woff') format('woff'), /* Modern Browsers */
        url('../fonts/inconsolata-v31-latin-regular.ttf') format('truetype'), /* Safari, Android, iOS */
        url('../fonts/inconsolata-v31-latin-regular.svg#Inconsolata') format('svg'); /* Legacy iOS */
  }

  .box {
    width: 380px;
    height: 380px;

    font-family: 'Inconsolata-700';
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    margin-top: 60px;
  }

body {
  background-color: rgb(221, 238, 228);
} 

</style>
