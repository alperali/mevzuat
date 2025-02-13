/*---------------------------------------------------------------------------
 * Mevzuat, https://github.com/alperali/mevzuat
 * Telif Hakkı/Copyright A. Alper Atıcı
 *---------------------------------------------------------------------------*/

import hecele from './hecele.js';

const nokim = /([\s\u00AD\u2010,;:.'"’“”!?\/()&#-]+)/;
const k13 = /^([aeiouöüıİ])[\u00AD\u2010]|[\u00AD\u2010]([aeiouöüıİ])$/gi;
const ptrn_xlit = /[âÂîÎûÛ]/g;
let r;

const translit = (() => {
  const m = {
    'â': 'a',
    'Â': 'A',
    'î': 'i',
    'Î': 'İ',
    'û': 'u',
    'Û': 'U'
  };
  return (e => m[e]);
})();

self.addEventListener('message', e => {
  switch (e.data.msg) {
    case 'hazır':
      // yukarıda sayfa yükleme tamamlanmış, biz de hazır olduğumuzu iletelim, yukarısı hecelenecek metinleri göndermeye başlasın varsa
      postMessage({msg:'hazır'});
      break;
    case 'hecele':
      r = e.data.hcl.replace(ptrn_xlit, translit)
                .split(nokim)
                .map((e) => {
                    if (nokim.test(e)) return e;
                    return hecele(e, hecele.SHY).replace(k13, '$1$2');
                  })
                .join('');
      postMessage({msg:'yanıt', r});
      break;
    default:
      console.error('seslemle worker: bilinmeyen mesaj geldi.');
  }
});
