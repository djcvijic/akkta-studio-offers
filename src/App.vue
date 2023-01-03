<template>
  <div id="app">
    <AkktaStudioOffers msg="Welcome to Your Vue.js App"/>
  </div>
</template>

<script>
import AkktaStudioOffers from './components/AkktaStudioOffers.vue'

export default {
  name: 'App',
  components: {
    AkktaStudioOffers
  }
}
</script>

<style>
@font-face {
    font-family: "Proxima Nova";
    src: url("@/assets/fonts/ProximaNova.otf");
}

html {
    box-sizing: border-box;
}

*,
*:before,
*:after {
    box-sizing: inherit;
}

p {
    margin: 0;
}

body {
    margin: 0;
    padding: 0 0 32px 0;
    background-color: white;
    font-family: "Proxima Nova", "HelveticaNeue", "Helvetica Neue", Helvetica, Arial, sans-serif;
}
</style>
