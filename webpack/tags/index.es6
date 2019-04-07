import axios from 'axios'
import {debounce} from 'lodash'
import tmpl from './items.pug'
function init() {
  const $roots = $('.js-concert__tags')
  if ($roots.length === 0) return;
  $('.js-concert__tag-input').on('input', debounce(onInput, 500))
}

function onInput(event) {
  const $t = $(this)
  console.log($t.val(), $t.data('endpoint'))
  axios.get($t.data('endpoint'), {params: {q: $t.val()}}).then(resp => {
    $(`.${$t.attr('id')}`).html(tmpl({concert_id: $t.data('concert-id'), items: resp.data, kind: $t.data('kind')}))
  }).catch(err => {
    console.error(err)
  })
}

$(document).on('click', '.js-tag-select-item', function(event) {
  event.preventDefault()
  const $t = $(this)
  axios.post(`/api/concerts/${$t.data('concert-id')}/concert_tags`, {
    concert_tag: {
      [keyFor($t.data('kind'))]: $t.data('id')
    }
  }).then(resp => {
    $(`.js-concert-tags-for-${$t.data('concert-id')}`).html(resp.data)
  }).catch(err => {
    console.error(err)
    alert('Ошибка сервера')
  })
})

function keyFor(kind) {
  return {
    composers: 'composer_id',
    pieces: 'piece_id',
    performers: 'performer_id',
  }[kind]
}

document.addEventListener('turbolinks:load', init)
