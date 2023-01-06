<template>
    <tr>
        <td>{{ itemIndex + 1 }}</td>
        <td>
            <img :src="imageData.uri"/>
            <label>
                Izaberi sliku
                <input type="file" style="display: none;" accept="image/png, image/gif, image/jpeg" @change="onUploadImage"/>
            </label>
        </td>
        <td><EditableSpan :value="value.patternPrice" @input="newValue => emitInput('patternPrice', newValue)"/> EUR</td>
        <td><EditableSpan :value="value.modelPrice" @input="newValue => emitInput('modelPrice', newValue)"/> EUR</td>
        <td><EditableSpan :value="value.samplePrice" @input="newValue => emitInput('samplePrice', newValue)"/> EUR</td>
        <td>
            {{ value.totalPrice }} EUR
        </td>
        <span class="removeItem" @click="removeItem">Obriši</span>
    </tr>
</template>

<script>
import EditableSpan from './EditableSpan.vue';

var resizeImage = function (file, maxSize) {
    var reader = new FileReader();
    var image = new Image();
    var canvas = document.createElement('canvas');
    var dataURItoBlob = function (dataURI) {
        var bytes = dataURI.split(',')[0].indexOf('base64') >= 0 ?
            atob(dataURI.split(',')[1]) :
            unescape(dataURI.split(',')[1]);
        var mime = dataURI.split(',')[0].split(':')[1].split(';')[0];
        var max = bytes.length;
        var ia = new Uint8Array(max);
        for (var i = 0; i < max; i++)
            ia[i] = bytes.charCodeAt(i);
        return new Blob([ia], { type: mime });
    };
    var resize = function () {
        var width = image.width;
        var height = image.height;
        if (width > height) {
            if (width > maxSize) {
                height *= maxSize / width;
                width = maxSize;
            }
        } else {
            if (height > maxSize) {
                width *= maxSize / height;
                height = maxSize;
            }
        }
        canvas.width = width;
        canvas.height = height;
        canvas.getContext('2d').drawImage(image, 0, 0, width, height);
        var dataUrl = canvas.toDataURL('image/jpeg');
        return dataURItoBlob(dataUrl);
    };
    return new Promise(function (ok, no) {
        if (!file.type.match(/image.*/)) {
            no(new Error("Not an image"));
            return;
        }
        reader.onload = function (readerEvent) {
            image.onload = function () { return ok(resize()); };
            image.src = readerEvent.target.result;
        };
        reader.readAsDataURL(file);
    });
};

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
  mounted() {
    const newModel = Object.assign({}, this.value);
    newModel.totalPrice = newModel.patternPrice + newModel.modelPrice + newModel.samplePrice;
    this.$emit('input', newModel);
  },
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
            const image = files[0];
            resizeImage(image, 300).then(imageResized => {
                fileReader.readAsDataURL(imageResized);
            }).catch(err => {
                console.error(err);
            });
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
    removeItem() {
        this.$emit('remove');
    },
  }
}
</script>

<style scoped>
.removeItem {
    display: inline-block;
    border: 1px solid #000;
    cursor: pointer;
    padding: 5px;
}

@media print {
    .removeItem {
        display: none;
    }
}

td {
    border: 1px solid #000;
    border-collapse: collapse;
    padding: 15px;
}

td > img {
    max-width: 100%;
    max-height: 150px;
}

td > label {
    display: block;
    border: 1px solid #000;
    cursor: pointer;
    padding: 5px;
    text-align: center;
}

@media print {
    td > label {
        display: none;
    }
}
</style>
