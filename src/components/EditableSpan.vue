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
        border-bottom: 1px solid #000;
        text-align: right;
    }
</style>
