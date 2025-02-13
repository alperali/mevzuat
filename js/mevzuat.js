/*---------------------------------------------------------------------------
 * Mevzuat, https://github.com/alperali/mevzuat
 * Telif Hakkı/Copyright A. Alper Atıcı
 *---------------------------------------------------------------------------*/

function atıf_göster(e) {
  const idx = e.target.innerText?.split('-')[1].split(' ')[0];
  const [kn, mn] = idx?.split('/');

  document.querySelector('dialog>form #diagkn').innerHTML = kn;
  document.querySelector('dialog>form #diagmn').innerHTML = mn;
  document.querySelector('dialog>form>p').innerHTML = document.querySelector(`p[data-idx="${idx}"]`).innerText?.replace(/\n/g,'<br />');
  document.querySelector('dialog').showModal();
}

document.querySelectorAll("a").forEach(a => a.addEventListener("click", atıf_göster));
document.querySelector("dialog>form>button").addEventListener("click", document.querySelector('dialog').close());

const hclwrk = new Worker('./js/seslemle.js', { type: 'module' });
const hclnodes = document.querySelectorAll('.hcl');
let n = 0, cn = 0;

hclwrk.addEventListener('message', e => {
  if (e.data.msg == 'yanıt') {
    hclnodes[n].childNodes[cn].nodeValue = e.data.r;
    cn++;
  }

  while (n < hclnodes?.length) {
    while (cn < hclnodes[n].childNodes.length)
      if (hclnodes[n].childNodes[cn].nodeType == 3) {
        hclwrk.postMessage({msg:'hecele', hcl: hclnodes[n].childNodes[cn].nodeValue});
        return;
      }
      else
        ++cn;

    cn = 0;
    n++;
  }

});

hclwrk.postMessage({msg:'hazır'});