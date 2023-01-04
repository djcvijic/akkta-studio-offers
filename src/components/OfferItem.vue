<template>
    <tr>
        <td>1</td>
        <td>
            <img src="@/assets/images/image-000.png"/>
        </td>
        <td>95 EUR</td>
        <td>170 EUR</td>
        <td>170 EUR</td>
        <td>435 EUR</td>
    </tr>
</template>

<script>
export default {
  name: 'OfferItem',
  props: {}
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
