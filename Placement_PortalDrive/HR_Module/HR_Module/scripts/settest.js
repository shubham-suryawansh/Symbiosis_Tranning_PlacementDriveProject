document.addEventListener('DOMContentLoaded', function () {
    var answerContainer = document.getElementById('answersContainer');
    var addAnswerButton = document.getElementById('addAnswerButton');

    addAnswerButton.addEventListener('click', function () {
        var answerInput = document.createElement('input');
        answerInput.type = 'text';
        answerInput.name = 'answer';
        answerInput.className = 'form-control mt-2';
        answerContainer.appendChild(answerInput);
    });
});
