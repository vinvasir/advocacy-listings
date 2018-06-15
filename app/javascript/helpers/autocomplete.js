import autocomplete from 'autocomplete.js'
import algolia from 'algoliasearch'

const index = algolia('XAWZT0909K', 'fafe2e89d23fd526945600dbe1040723')

export const listingsautocomplete = (selector, {categoryId, areaIds}) => {
  let listings = index.initIndex('Organization_development')

  let areaFilters = 'area.id = ' + areaIds.join(' OR area.id = ');
  let filters = areaFilters

  if (typeof categoryId !== 'undefined') {
    filters = filters + ' AND category.id != ' + categoryId
  }

  let sources = [{
    source: autocomplete.sources.hits(listings, { hitsPerPage: 5, filters: filters }),
    templates: {
      header: () => {
        if (typeof categoryId !== 'undefined') {
          return `<div class="aa-suggestions-category">Other categories</div>`;
        }

        return `<div class="aa-suggestions-category">All categories</div>`;
      },
      footer: `<div>Search by Algolia</div>`,
      suggestion (suggestion) {
        return `<span><a href="">${suggestion.title}</a> in ${suggestion.category.name}</span> 
                <span>${suggestion.created_at_human} &bull; ${suggestion.area.name}</span>`
      }
    },
    display: 'title',
    empty: `<div class="aa-empty">No listings found.</div>`
  }];

  if (typeof categoryId !== 'undefined') {
    sources.unshift({
      source: autocomplete.sources.hits(listings, { 
        hitsPerPage: 5, 
        filters: `(${areaFilters}) AND category.id = ${categoryId} AND live = 1`
      }),
      templates: {
        header: `<div class="aa-suggestions-category">This category</div>`,
        suggestion (suggestion) {
          return `<span><a href="/${suggestion.area.slug}/${suggestion.id}">${suggestion.title}</a> in ${suggestion.category.name}</span> 
                <span>${suggestion.created_at_human} &bull; ${suggestion.area.name}</span>`
        }
      },
      display: 'title',
      empty: `<div class="aa-empty">No listings found.</div>`
    })
  }

  return autocomplete(selector, {}, sources)
}