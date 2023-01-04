<template>
  <div id="akkta-studio-offers">
    <OfferMenu/>
    <OfferMain/>
  </div>
</template>

<script>
import OfferMenu from './OfferMenu.vue'
import OfferMain from './OfferMain.vue'

export default {
  name: 'AkktaStudioOffers',
  components: {
    OfferMenu,
    OfferMain,
  },
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
