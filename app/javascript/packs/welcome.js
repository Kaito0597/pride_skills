import {MDCFloatingLabel} from '@material/floating-label';

const createGameFloatingLabel = new MDCFloatingLabel(document.querySelector('#create-game-label'));
const joinGameFloatingLabel = new MDCFloatingLabel(document.querySelector('#join-game-label'));

$('#create-game-text-field').on('focus', function() {
    createGameFloatingLabel.float(true)
})
$('#create-game-text-field').on('focusout', function() {
    if ($(this).val() == "") {
        createGameFloatingLabel.float(false)
    }
})

$('#join-game-text-field').on('focus', function() {
    joinGameFloatingLabel.float(true)
})
$('#join-game-text-field').on('focusout', function() {
    if ($(this).val() == "") {
        joinGameFloatingLabel.float(false)
    }
})