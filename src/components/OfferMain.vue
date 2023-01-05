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
                Sačuvaj ponudu
            </a>
            <label>
                Učitaj ponudu
                <input type="file" style="display: none;" accept="application/octet-stream" @change="loadOffer"/>
            </label>
            <label>
                Štampaj ponudu
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
                        <li>Digitalni šablon modela i prateća tehnička dokumentacija u dogovorenoj veličini</li>
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
                    <OfferItem
                        v-for="(_, index) in offerItems"
                        :key="index"
                        :item-index="index"
                        v-model="offerItems[index]"
                        :image-data="offerImages[index]"
                        @changeImage="newImageData => onChangeImage(index, newImageData)"
                        @remove="removeItem(index)"
                    />
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
            <span class="addItem" @click="addItem">Dodaj</span>
        </div>
        <div class="contract">
            <p>
                Rok za izradu kolekcije bi bio oko <EditableSpan v-model="dueDate"/>. Dinamika fitinga se dogovara u toku rada.
                <br/>Nakon prihvatanja ponude neophodna je uplata avansa u iznosu od 40% od cene. Ostatak isplate je nakon završetka kolekcije.
                <br/>Klijent obezbeđuje materijale i pozamanteriju za izradu kolekcije u dogovorenom terminu.
                <br/>Gradiranje kolekcije je moguće u željenim veličinama i možemo dati ponudu prema vašem zahtevu.
                <br/>Svaka izmena dizajna nakon finalnog dogovora se dodatno naplaćuje.
            </p>
            <div class="contractSignatures">
                <div>
                    <p>AKKTA STUDIO:</p>
                    <br/>
                    <br/>
                    <br/>
                    <hr/>
                    <p>Tatjana Vuleta Đukanov</p>
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
        offerItems: [],
        offerImages: [],
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
    addItem() {
        this.offerItems.push({
            patternPrice: 0,
            modelPrice: 0,
            samplePrice: 0,
            totalPrice: 0,
        });
        this.offerImages.push({ uri: '' });
    },
    removeItem(index) {
        this.offerItems.splice(index, 1);
        this.offerImages.splice(index, 1);
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

.addItem {
    display: inline-block;
    border: 1px solid #000;
    cursor: pointer;
    padding: 5px;
    text-align: center;
}

@media print {
    .addItem {
        display: none;
    }
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
