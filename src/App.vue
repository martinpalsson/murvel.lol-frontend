<template>
  <div class="container mx-auto my-auto lg:w-96 md:w-96 sm:w-96 rounded-md ">
    <!-- Navbar -->
    <nav class="container mx-auto">
      <div class="flex item-center justify-between">
        <!-- murvel.lol logo -->
        <div class="pt-2 px-4">
          <h2 class="text-4xl font-light font-inconsolata">
            murvel.lol
          </h2>
        </div>
      </div>
    </nav>
    <!-- Title bar -->
    <div class="container mx-auto pt-2">
      <div class="">
        <div class="flex  space-x-2 font-inconsolata font-light text-black text-md bg-black/10">
          <a href="https://www.bubb.la" target="_blank">
            <div class="px-4 py-1  rounded-r-full bg-white hover:bg-amber-50">
              bubb.la
            </div>
          </a>
          <div class="container flex flex-row justify-around">
            <div 
              class="w-1/5 flex justify-center py-2 rounded-full hover:bg-amber-50 hover:cursor-pointer"
              @click="previousCategory"
            >
              <vueFeather type="chevrons-left" size="16" />
            </div>
            <a :href="selectedCategoryLink" target="_blank" class="w-3/5">
              <div class="w-full flex justify-center text-base pt-1 pb-1 hover:bg-amber-50 hover:cursor-pointer rounded-full">
                {{selectedCategoryCapitals}}
              </div>
            </a>
            <div 
              class="w-1/5 flex justify-center py-2 -mr-px rounded-l-full hover:bg-amber-50 hover:cursor-pointer"
              @click="nextCategory"
            >
              <vueFeather type="chevrons-right" size="16" />
            </div>

          </div>
        </div>
      </div>
    </div>
    <!-- Robot section -->
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

const selectedCategoryLink = computed(() => {
  const cat = categories.value[selectedIx.value].toLowerCase()
  // 'All' is a conceptional category, doesn't exist.
  if (cat === "all") {
    return `https://www.bubb.la/`
  } else {
    return `https://www.bubb.la/${cat}`
  }
  
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

body {
  background-color: rgb(221, 238, 228);
} 

</style>
