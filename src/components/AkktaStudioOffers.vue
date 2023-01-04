<template>
  <div id="akkta-studio-offers">
    <OffersMenu/>
    <OffersMain/>
  </div>
</template>

<script>
import OffersMenu from './OffersMenu.vue'
import OffersMain from './OffersMain.vue'

export default {
  name: 'AkktaStudioOffers',
  components: {
    OffersMenu,
    OffersMain,
  },
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
