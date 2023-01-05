<template>
    <div class="main">
        <div class="menu">
            <label>
                Ime ponude:
                <input type="text" v-model="offerName"/>
            </label>
            <a
                :href="!!offerName ? `data:application/json;charset=utf-8,${saveJson}` : 'javascript:;'"
                :download="!!offerName ? `${offerName}.json` : false"
                :class="!!offerName ? '' : 'disabledLink'"
            >
                Sacuvaj ponudu
            </a>
            <label>
                Ucitaj ponudu
                <input type="file" style="display: none;" accept="application/json" @change="loadOffer"/>
            </label>
            <label>
                Kreiraj novu ponudu
                <input type="button" style="display: none;" @click="clearOffer"/>
            </label>
            <label>
                Stampaj ponudu
                <input type="button" style="display: none;" @click="printOffer"/>
            </label>
        </div>
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
                        <th>{{ grandTotalPrice }} EUR</th>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div class="footer"></div>
    </div>
</template>

<script>
import saveState from 'vue-save-state';
import OfferItem from './OfferItem.vue';

function initialState() {
    return {
        offerName: '',
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
    }
}

export default {
  name: 'OfferMain',
  mixins: [saveState],
  components: {
    OfferItem
  },
  props: {},
  data() {
    return initialState();
  },
  computed: {
    grandTotalPrice() {
        return this.offerItems.reduce((total, item) => total + item.totalPrice, 0);
    },
    saveJson() {
        return JSON.stringify(this.$data);
    },
  },
  methods: {
    onChangeImage(itemIndex, newImageData) {
        this.$set(this.offerImages, itemIndex, newImageData);
    },
    getSaveStateConfig() {
        return {
            cacheKey: 'AkktaStudioOffers',
        };
    },
    loadOffer(event) {
        const fileReader = new FileReader();
        const callback = this.onOfferLoaded;
        fileReader.onloadend = function () {
            const newOfferJson = fileReader.result;
            callback(newOfferJson);
            event.target.value = '';
        };

        const files = event.target.files;
        if (files.length > 0) {
            fileReader.readAsText(files[0]);
        }
    },
    onOfferLoaded(newOfferJson) {
        const newOfferData = JSON.parse(newOfferJson);
        for (const key in newOfferData) {
            this.$data[key] = newOfferData[key];
        }
    },
    clearOffer() {
        const newOfferData = initialState();
        for (const key in newOfferData) {
            this.$data[key] = newOfferData[key];
        }
    },
    printOffer() {
        window.print();
    },
  },
}
</script>

<style scoped>
.main {
    margin: auto;
    width: 900px;
}

.menu > * {
    display: block;
    width: 300px;
    margin: 20px 0;
    border: 1px solid #000;
    cursor: pointer;
    padding: 5px;
    text-align: center;
}

.content > table {
    width: 100%;
    table-layout: fixed;
}

.content > table, .content > table th {
    border: 1px solid #000;
    border-collapse: collapse;
}

.content > table th {
    padding: 10px;
}

.content > table th:nth-child(1) { width: 7.5%; }
.content > table th:nth-child(2) { width: 25%; }
.content > table th:nth-child(3) { width: 17.5%; }
.content > table th:nth-child(4) { width: 17.5%; }
.content > table th:nth-child(5) { width: 17.5%; }
.content > table th:nth-child(6) { width: 15%; }

.disabledLink {
    color: currentColor;
    cursor: not-allowed;
    opacity: 0.5;
    text-decoration: none;
}
</style>
