<template>
  <div class="container mx-auto my-auto lg:w-96 md:w-96 sm:w-96 rounded-md ">
    <!-- Navbar -->
    <nav class="container mx-auto">
      <div class="flex item-center justify-between">
        <!-- Logo -->
        <div class="pt-2 px-4">
          <h2 class="text-4xl font-extralight font-inconsolata">
            murvel.lol
          </h2>
        </div>
      </div>
    </nav>
    <!-- Title bar -->
    <div class="container mx-auto pt-2">
      <div class="">
        <div class="flex items-center space-x-2 font-inconsolata font-light text-black text-md bg-black/10">
          <div class="px-4 py-1  rounded-r-full bg-white hover:bg-amber-50">
            bubb.la
          </div>
          <div class="container flex flex-row justify-around">
            <div 
              class="w-1/5 flex justify-center py-2 rounded-full hover:bg-amber-50 hover:cursor-pointer"
              @click="previousCategory"
            >
              <vueFeather type="chevrons-left" size="16" />
            </div>
            <div class="w-3/5 flex justify-center text-base pt-1">{{selectedCategoryCapitals}}</div>
            <div 
              class="w-1/5 flex justify-center py-2 rounded-full hover:bg-amber-50 hover:cursor-pointer"
              @click="nextCategory"
            >
              <vueFeather type="chevrons-right" size="16" />
            </div>

          </div>
        </div>
      </div>
    </div>
    <!-- Hero section -->
    <section id="robot">
      <Suspense>
        <MurvelRobot2 :category="selectedCategory"/>
        <template #fallback>
        ...
        </template>
      </Suspense>
    </section>
    <footer class="bg-black/10 px-4">
      <p class="font-inconsolata text-md font-light text-start">murvel.lol 2022</p>
    </footer>
  </div>
<!-- <Suspense>
  <MurvelRobot category="All"/>
  <template #fallback>
    Laddar...
  </template>
</Suspense> -->
</template>

<script setup>
import {ref, computed} from 'vue'
import MurvelRobot2 from './components/MurvelRobot.vue'

const categories = ref([
  'Sverige',
  'Världen',
  'Nordamerika',
  'Blandat',
  'Afrika',
  'Politik',
  'Europa',
  'Opinion',
  'Asien',
  'Latinamerika',
  'Media',
  'Mellanöstern',
  'Teknik',
  'Vetenskap',
  'All',
])
const selectedIx = ref(0)

const selectedCategory = computed(() => {
  return categories.value[selectedIx.value]
})

const selectedCategoryCapitals = computed(() => {
  return categories.value[selectedIx.value].toUpperCase()
})

function nextCategory() {
  selectedIx.value++
  if (selectedIx.value >= categories.value.length) {
    selectedIx.value = 0
  }
}

function previousCategory() {
  selectedIx.value--
  if (selectedIx.value < 0) {
    selectedIx.value = categories.value.length - 1
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
