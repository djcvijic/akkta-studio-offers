<template>
    <tr>
        <td>{{ itemIndex }}</td>
        <td>
            <img src="@/assets/images/image-000.png"/>
        </td>
        <td>{{ patternPrice }} EUR</td>
        <td>{{ modelPrice }} EUR</td>
        <td>{{ samplePrice }} EUR</td>
        <td>{{ totalPrice }} EUR</td>
    </tr>
</template>

<script>
export default {
  name: 'OfferItem',
  props: {
    itemIndex: {
        type: Number,
        default: 0,
    },
    imageData: {
        type: String,
        default: '',
    },
    patternPrice: {
        type: Number,
        default: 0,
    },
    modelPrice: {
        type: Number,
        default: 0,
    },
    samplePrice: {
        type: Number,
        default: 0,
    },
  },
  computed: {
    totalPrice() {
        return this.patternPrice + this.modelPrice + this.samplePrice;
    }
  }
}
</script>

<style scoped>
td {
    border: 1px solid #000;
    border-collapse: collapse;
}

td {
    padding: 10px;
}

td > img {
    height: 150px;
}
</style>
