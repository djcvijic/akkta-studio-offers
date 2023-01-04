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
                    <OfferItem :item-index="0" v-model="offerItems[0]" :image-data="offerImages[0]" @changeImage="newImageData => onChangeImage(0, newImageData)"/>
                    <OfferItem :item-index="1" v-model="offerItems[1]" :image-data="offerImages[1]" @changeImage="newImageData => onChangeImage(1, newImageData)"/>
                    <OfferItem :item-index="2" v-model="offerItems[2]" :image-data="offerImages[2]" @changeImage="newImageData => onChangeImage(2, newImageData)"/>
                    <OfferItem :item-index="3" v-model="offerItems[3]" :image-data="offerImages[3]" @changeImage="newImageData => onChangeImage(3, newImageData)"/>
                    <OfferItem :item-index="4" v-model="offerItems[4]" :image-data="offerImages[4]" @changeImage="newImageData => onChangeImage(4, newImageData)"/>
                    <OfferItem :item-index="5" v-model="offerItems[5]" :image-data="offerImages[5]" @changeImage="newImageData => onChangeImage(5, newImageData)"/>
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
  props: {},
  data() {
    return {
        offerItems: [
            {
                patternPrice: 95,
                modelPrice: 170,
                samplePrice: 170,
                totalPrice: 435,
            },
            {
                patternPrice: 95,
                modelPrice: 170,
                samplePrice: 170,
                totalPrice: 435,
            },
            {
                patternPrice: 95,
                modelPrice: 170,
                samplePrice: 170,
                totalPrice: 435,
            },
            {
                patternPrice: 95,
                modelPrice: 170,
                samplePrice: 170,
                totalPrice: 435,
            },
            {
                patternPrice: 95,
                modelPrice: 170,
                samplePrice: 170,
                totalPrice: 435,
            },
            {
                patternPrice: 95,
                modelPrice: 170,
                samplePrice: 170,
                totalPrice: 435,
            },
        ],
        offerImages: [
            { uri: '' },
            { uri: '' },
            { uri: '' },
            { uri: '' },
            { uri: '' },
            { uri: '' },
        ],
        grandTotalPrice: 0,
    }
  },
  methods: {
    onChangeImage(itemIndex, newImageData) {
        this.$set(this.offerImages, itemIndex, newImageData);
    },
  },
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
