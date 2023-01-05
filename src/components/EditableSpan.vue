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
        this.$refs.editable.innerText = this.value;
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
    min-width: 20px;
    border-bottom: 1px solid gray;
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
