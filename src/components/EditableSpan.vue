<template>
    <span
        ref="editable"
        contenteditable
        v-on="listeners"
    ></span>
</template>

<script>
export default {
    name: 'EditableSpan',
    props: {
        value: {
            default: '',
        },
    },
    computed: {
        listeners() {
            return { ...this.$listeners, input: this.onInput };
        },
    },
    updated() {
        if (this.value != this.$refs.editable.innerText)
        {
            this.$refs.editable.innerText = this.value;
        }
    },
    methods: {
        onInput(e) {
            this.$emit('input', e.target.innerText);
        },
    },
};
</script>

<style scoped>
span {
    display: inline-block;
    min-width: 30px;
    border-bottom: 1px dashed gray;
    text-align: right;
}

@media print {
    span {
        min-width: 0;
        border-bottom: none;
        text-align: start;
    }
}
</style>
