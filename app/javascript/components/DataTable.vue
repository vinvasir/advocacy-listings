<template>
    <div class="col-md-8 col-md-offset-2">
        <div class="panel panel-default">
            <div class="panel-heading">{{ table }}</div>

            <div class="panel-body">
                <form action="#" @submit.prevent="getRecords">
                    <label for="search">Search</label>
                    <div class="row row-fluid">
                        <div class="form-group col-md-3">
                           <select class="form-control" v-model="search.column">
                               <option :value="column" v-for="column in displayable">
                                {{ column }}
                               </option>
                           </select> 
                        </div>

                        <div class="form-group col-md-3">
                            <select class="form-control" v-model="search.operator">
                                <option value="equals">=</option>
                                <option value="contains">contains</option>
                                <option value="starts_with">starts with</option>
                                <option value="ends_with">end with</option>
                                <option value="greater_than">greater than</option>
                                <option value="less_than">less than</option>
                            </select>
                        </div>

                        <div class="form-group col-md-6">
                            <div class="input-group">
                                <input type="text" id="search" v-model="search.value" class="form-control">

                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit">Search</button>
                                </span>
                            </div>
                            
                        </div>
                    </div>
                </form>

                <div class="row">
                    <div class="form-group col-md-10">
                        <label for="filter">Quick search current results</label>
                        <input type="text" v-model="quickSearchQuery" id="filter" class="form-control">
                    </div>

                    <div class="form-group col-md-2">
                        <label for="limit">Display records</label>
                        <select id="limit" v-model="limit" @change="getRecords" class="form-control">
                            <option value="10">10</option>
                            <option value="50">50</option>
                            <option value="250">250</option>
                            <option value="1000">1000</option>
                            <option value="">All</option>
                        </select>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th v-for="column in displayable">
                                    <span class="sortable" @click="sortBy(column)">{{ column }}</span>

                                    <div :class="`arrow arrow--${sort.order}`" v-if="sort.key === column"></div>
                                </th>
                                <th>&nbsp</th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr v-for="record in filteredRecords">
                                <td v-for="(value, column) in record">

                                    <template v-if="isUpdatable(column) && editing.id === record.id">
                                        <div class="form-group" :class="{ 'has-error': editing.errors[column] }">
                                            <input class="form-control" v-model="editing.form[column]" v-if="updatable.indexOf(column) > -1">
                                        </div>

                                        <span class="help-block" v-if="editing.errors[column]">
                                            <strong>{{ editing.errors[column][0] }}</strong>
                                        </span>
                                    </template>

                                    <template v-if="!isUpdatable(column) || editing.id !== record.id">
                                        {{ value }}
                                    </template>
                                    
                                </td>

                                <td>
                                    <a href="" v-if="editing.id !== record.id" @click.prevent="edit(record)">Edit</a>

                                    <template v-if="editing.id === record.id">
                                        <a href="" @click.prevent="update">Save</a>
                                        <a href="" @click.prevent="cancel">Cancel</a>
                                    </template>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import queryString from 'query-string'
    import axios from 'axios'
    import _ from 'lodash'

    let token = document.head.querySelector('meta[name="csrf-token"]');

    if (token) {
        axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content;
    }

    export default {
        props: ['endpoint'],
        data() {
            return {
                table: '',
                displayable: [],
                updatable: [],
                records: [],
                quickSearchQuery: '',
                limit: 50,
                sort: {
                    key: 'id',
                    order: 'asc'
                },
                editing: {
                    id: null,
                    form:  {

                    },
                    errors: {}
                },
                search: {
                    value: '',
                    operator: 'equals',
                    column: 'id'
                }
            }
        },
        computed: {
            filteredRecords() {
                let data = this.records;

                data = data.filter(row => {
                    return Object.keys(row).some(key => {
                        return String(row[key]).toLowerCase().indexOf(this.quickSearchQuery.toLowerCase()) > -1;
                    });
                });

                if (this.sort.key) {
                    data = _.orderBy(data, i => {
                        let value = i[this.sort.key];

                        if (!isNaN(parseFloat(value))) {
                            return parseFloat(value)
                        }

                        return String(value).toLowerCase();
                    }, this.sort.order);
                }

                return data;
            }
        },
        methods: {
            cancel() {
                this.editing.id = null;
                this.editing.form = {};
                this.editing.errors = [];
            },
            edit(record) {
                this.editing.errors = [];
                this.editing.id = record.id;

                this.editing.form = _.pick(record, this.updatable);
            },
            getRecords() {
                axios.get(`${this.endpoint}?${this.getQueryParamaters()}`)
                     .then(({data}) => {
                        this.table = data.data.table;
                        this.displayable = data.data.displayable.map(displayable => {
                            if (displayable.split(' ').indexOf('as') > -1) {
                                return displayable.split(' ')[2];
                            }

                            return displayable;
                        });
                        this.updatable = data.data.updatable;
                        this.records = data.data.records;
                     })
            },
            getQueryParamaters() {
                return queryString.stringify({
                    limit: this.limit,
                    ...this.search
                })
            },
            isUpdatable(column) {
                return this.updatable.indexOf(column) > -1;
            },
            sortBy(column) {
                this.sort.key = column;
                this.sort.order = this.sort.order === 'asc' ? 'desc' : 'asc';
            },
            update() {
                axios.patch(`${this.endpoint}/${this.editing.id}`, this.editing.form)
                     .then(({data}) => {
                        this.getRecords().then(({data}) => {
                            this.editing.id = null
                            this.editing.form = {}
                        })
                     })
                     .catch(error => {
                        this.editing.errors = error.response.data.errors;
                     })
            }
        },
        mounted() {
            this.getRecords();
        }
    }
</script>

<style lang="scss">
    .sortable {
        cursor: pointer;
    }

    .arrow {
        display: inline-block;
        vertical-align: middle;
        width: 0;
        height: 0;
        margin-left: 5px;
        opacity: .6;

        &--asc {
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
            border-bottom: 4px solid #222;
        }

        &--desc {
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
            border-top: 4px solid #222;
        }        
    }
</style>