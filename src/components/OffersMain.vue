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
                    <tr>
                        <td>2</td>
                        <td>
                            <img src="@/assets/images/image-001.png"/>
                        </td>
                        <td>185 EUR</td>
                        <td>260 EUR</td>
                        <td>260 EUR</td>
                        <td>705 EUR</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>
                            <img src="@/assets/images/image-002.png"/>
                        </td>
                        <td>95 EUR</td>
                        <td>170 EUR</td>
                        <td>170 EUR</td>
                        <td>435 EUR</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>
                            <img src="@/assets/images/image-003.png"/>
                        </td>
                        <td>105 EUR</td>
                        <td>170 EUR</td>
                        <td>170 EUR</td>
                        <td>445 EUR</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>
                            <img src="@/assets/images/image-004.png"/>
                        </td>
                        <td>70 EUR</td>
                        <td>170 EUR</td>
                        <td>170 EUR</td>
                        <td>410 EUR</td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>
                            <img src="@/assets/images/image-005.png"/>
                        </td>
                        <td>110 EUR</td>
                        <td>170 EUR</td>
                        <td>170 EUR</td>
                        <td>450 EUR</td>
                    </tr>
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
export default {
  name: 'OffersMain',
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

.content > table, .content > table th, .content > table td {
    border: 1px solid #000;
    border-collapse: collapse;
}

.content > table th, .content > table td {
    padding: 10px;
}

.content > table img {
    height: 150px;
}
</style>
