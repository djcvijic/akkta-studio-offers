<template>
    <tr>
        <td>{{ itemIndex + 1 }}</td>
        <td>
            <img :src="imageData.uri"/>
            <label for="imageUpload">Izaberi sliku</label>
            <input id="imageUpload" type="file" style="display: none;" accept="image/png, image/gif, image/jpeg" @change="onUploadImage"/>
        </td>
        <td><EditableSpan :value="value.patternPrice" @input="newValue => emitInput('patternPrice', newValue)"/> EUR</td>
        <td><EditableSpan :value="value.modelPrice" @input="newValue => emitInput('modelPrice', newValue)"/> EUR</td>
        <td><EditableSpan :value="value.samplePrice" @input="newValue => emitInput('samplePrice', newValue)"/> EUR</td>
        <td>{{ value.totalPrice }} EUR</td>
    </tr>
</template>

<script>
import EditableSpan from './EditableSpan.vue';

export default {
  name: 'OfferItem',
  components: {
    EditableSpan,
  },
  props: {
    itemIndex: {
        type: Number,
        default: 0,
    },
    value: {
        type: Object,
        default() {
            return  {
                patternPrice: 0,
                modelPrice: 0,
                samplePrice: 0,
                totalPrice: 0,
            };
        },
    },
    imageData: {
        type: Object,
        default() {
            return {
                uri: '',
            };
        },
    },
  },
  computed: {},
  methods: {
    onUploadImage(event) {
        const fileReader = new FileReader();
        const callback = this.emitChangeImage;
        fileReader.onloadend = function () {
            const newImageUri = fileReader.result;
            callback(newImageUri);
        };

        const files = event.target.files;
        if (files.length > 0) {
            fileReader.readAsDataURL(files[0]);
        }
    },
    emitChangeImage(newImageUri) {
        const newImageData = Object.assign({}, this.imageData);
        newImageData.uri = newImageUri
        this.$emit('changeImage', newImageData);
    },
    emitInput(key, newValue) {
        const newModel = Object.assign({}, this.value);
        newModel[key] = parseInt(newValue);
        newModel.totalPrice = newModel.patternPrice + newModel.modelPrice + newModel.samplePrice;
        this.$emit('input', newModel);
    },
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

td > label {
    display: block;
    border: 1px solid #000;
    cursor: pointer;
    padding: 5px;
    text-align: center;
}
</style>