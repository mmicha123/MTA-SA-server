/*
document.addEventListener('keypress', logKey);

function logKey(e) {
    if (e.keyCode === 32) {
        notify("Test", "javascript", "hay whats op m8 hope this works", 3, false)
    }
}
*/


//document.getElementById("card0").style.display = "none"

const icons = [
    { text: "info", color: "yellow" },
    { text: "help", color: "white" },
    { text: "done_all", color: "green" },
    { text: "error", color: "red" }
]

var id_counter = 0

/*
notify(title, sender, message, icon, flashing)
    title: string
    sender: string
    message: string
    icon: int (0 = info, 1 = help, 2 = succses, 3 = error)
    flashing: boolean
*/
function notify(title, sender, message, icon, flashing) {
    var itm = document.getElementById("card0")
    var cln = itm.cloneNode(true) //clone the default element

    cln.style.display = "block" //set visable
    cln.setAttribute("id", id_counter) //change id to delete item later
    document.getElementById("container").appendChild(cln) //add to container

    cln.getElementsByTagName('span')[0].innerHTML = title //title
    cln.getElementsByTagName('p')[0].innerHTML = sender //sender
    cln.getElementsByTagName('p')[1].innerHTML = message //message
    cln.getElementsByTagName('i')[0].innerHTML = icons[icon].text // icon text
    cln.getElementsByTagName('i')[0].style.color = icons[icon].color // icon text
    cln.style.opacity = 0
    setTimeout(() => cln.style.opacity = 1, 100);

    //flashing
    if (flashing) {
        var timer = setInterval(() => {
            if (getComputedStyle(cln).color[4] == 0) {
                cln.style.color = "#ffffff"
                cln.style.backgroundColor = "rgba(0, 0, 0, 0.42)";
            } else {
                cln.style.color = "#000000"
                cln.style.backgroundColor = "#ffffff";
            }
        }, 500);
    }

    setTimeout((id, t) => {
        try {
            var itm = document.getElementById(id)
            itm.parentNode.removeChild(itm);
            clearInterval(t)
        } catch (error) {}
    }, 5000, id_counter, timer)

    id_counter++
}