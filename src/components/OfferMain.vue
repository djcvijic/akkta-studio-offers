<template>
    <div class="main">
        <div class="header"></div>
        <div class="content">
            <table>
                <thead>
                    <tr>
                        <th>Broj</th>
                        <th>Model</th>
                        <th>Konstrukcija šablona</th>
                        <th>Izrada makete</th>
                        <th>Izrada uzorka</th>
                        <th>Zbir</th>
                    </tr>
                </thead>
                <tbody>
                    <OfferItem :item-index="1" :image-data="''" :pattern-price="95" :model-price="170" :sample-price="170"/>
                    <OfferItem :item-index="2" :image-data="''" :pattern-price="185" :model-price="260" :sample-price="260"/>
                    <OfferItem :item-index="3" :image-data="''" :pattern-price="95" :model-price="170" :sample-price="170"/>
                    <OfferItem :item-index="4" :image-data="''" :pattern-price="105" :model-price="170" :sample-price="170"/>
                    <OfferItem :item-index="5" :image-data="''" :pattern-price="70" :model-price="170" :sample-price="170"/>
                    <OfferItem :item-index="6" :image-data="''" :pattern-price="110" :model-price="170" :sample-price="170"/>
                </tbody>
                <tfoot>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th>2880 EUR</th>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div class="footer"></div>
    </div>
</template>

<script>
import OfferItem from './OfferItem.vue';

export default {
  name: 'OfferMain',
  components: {
    OfferItem
  },
  props: {}
}
</script>

<style scoped>
.main {
    margin: auto;
    width: 900px;
}

.content > table {
    width: 100%;
}

.content > table, .content > table th {
    border: 1px solid #000;
    border-collapse: collapse;
}

.content > table th {
    padding: 10px;
}

.content > table img {
    height: 150px;
}
</style>
