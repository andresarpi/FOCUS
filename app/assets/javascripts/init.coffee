class Page
    controller: () =>
        document.head.querySelector("[name=psj]").getAttribute('controller');
    action: () =>
        document.head.querySelector("[name=psj]").getAttribute('action');

       
@page = new Page

