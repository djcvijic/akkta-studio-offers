<template>
    <div class="main">
        <div class="menu">
            <label>
                Ime ponude:
                <input type="text" v-model="offerName"/>
            </label>
            <a
                :href="!!offerName ? `data:application/octet-stream;base64,${saveJson}` : 'javascript:;'"
                :download="!!offerName ? `${offerName}.bin` : false"
                :class="!!offerName ? '' : 'disabledLink'"
            >
                Sacuvaj ponudu
            </a>
            <label>
                Ucitaj ponudu
                <input type="file" style="display: none;" accept="application/octet-stream" @change="loadOffer"/>
            </label>
            <label>
                Stampaj ponudu
                <input type="button" style="display: none;" @click="printOffer"/>
            </label>
            <label>
                Kreiraj novu ponudu
                <input type="button" style="display: none;" @click="clearOffer"/>
            </label>
        </div>
        <div class="header">
            <div>&mdash; AKKTA STUDIO &mdash;</div>
            <div>Žitni trg bb, Zrenjanin</div>
            <div><EditableSpan v-model="offerDate"/></div>
        </div>
        <div class="content">
            <div>
                <p>
                    <EditableSpan v-model="offerTitle"/>
                </p>
                <p>
                    U cenu je uračunato:
                </p>
                <p>
                    <ul>
                        <li>Digitalni šablon modela i prateća tehnička dokumentacija u dogovorenoj velicini</li>
                        <li>Izrada makete modela za fiting i korekcije</li>
                        <li>Izrada nultog uzorka modela za slikanje i proizvodnju u industriji</li>
                    </ul>
                </p>
            </div>
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
        <div class="contract">
            <p>
                Rok za izradu kolekcije bi bio oko <EditableSpan v-model="dueDate"/>. Dinamika fitinga se dogovara u toku rada.
                <br/>Nakon prihvatanja ponude neophodna je uplata avansa u iznosu od 40% od cene. Ostatak isplate je nakon zavrsetka kolekcije.
                <br/>Klijent obezbedjuje materijale i pozamanteriju za izradu kolekcije u dogovorenom terminu.
                <br/>Gradiranje kolekcije je moguce u zeljenim velicinama i mozemo dati ponudu prema vasem zahtevu.
                <br/>Svaka izmena dizajna nakon finalnog dogovora se dodatno naplacuje.
            </p>
            <div class="contractSignatures">
                <div>
                    <p>AKKTA STUDIO:</p>
                    <br/>
                    <br/>
                    <br/>
                    <hr/>
                    <p>Tatjana Vuleta Djukanov</p>
                </div>
                <div></div>
                <div>
                    <p><EditableSpan v-model="clientName"/>:</p>
                    <br/>
                    <br/>
                    <br/>
                    <hr/>
                    <p>(POTPIS)</p>
                </div>
                <div>
                    <p><EditableSpan v-model="associateCompany"/>:</p>
                    <br/>
                    <br/>
                    <br/>
                    <hr/>
                    <p><EditableSpan v-model="associate"/></p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import saveState from 'vue-save-state';
import OfferItem from './OfferItem.vue';
import EditableSpan from './EditableSpan.vue';

function initialState() {
    return {
        offerName: '',
        offerDate: 'DATUM',
        offerTitle: 'NASLOV',
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
        dueDate: 'DATUM',
        clientName: 'KLIJENT',
        associateCompany: 'FIRMA SARADNIKA',
        associate: 'SARADNIK',
    }
}

export default {
  name: 'OfferMain',
  mixins: [saveState],
  components: {
    OfferItem,
    EditableSpan,
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
        return btoa(JSON.stringify(this.$data));
    },
  },
  methods: {
    getSaveStateConfig() {
        return {
            cacheKey: 'AkktaStudioOffers',
        };
    },
    onChangeImage(itemIndex, newImageData) {
        this.$set(this.offerImages, itemIndex, newImageData);
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
    printOffer() {
        window.print();
    },
    clearOffer() {
        const newOfferData = initialState();
        for (const key in newOfferData) {
            this.$data[key] = newOfferData[key];
        }
    },
  },
}
</script>

<style scoped>
.disabledLink {
    color: currentColor;
    cursor: not-allowed;
    opacity: 0.5;
    text-decoration: none;
}

.main {
    margin: auto;
    width: 800px;
}

.main > * {
    margin-bottom: 30px;
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

@media print {
    .menu {
        display: none;
    }
}

.header {
    display: grid;
    grid-template-columns: 1fr 1fr 2fr;
}

.header > div:last-child {
    text-align: right;
}

.content > div {
    background-color: midnightblue;
    color: white;
    font-size: 1.2em;
    font-weight: bold;
    padding: 15px 30px 5px;
}

.content > div > p {
    margin-bottom: 30px;
}

.content > div > p:first-child {
    text-align: center;
}

.content > div > p > ul {
    margin: 0;
    color: lightsteelblue;
}

.content > table {
    width: 100%;
    table-layout: fixed;
}

.content > table > thead {
    background-color: lightsteelblue;
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

.contract {
    page-break-inside: avoid;
}

.contractSignatures {
    margin-top: 30px;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    row-gap: 60px;
}
</style>
