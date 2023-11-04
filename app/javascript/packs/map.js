// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.GOOGLE_API_KEY
});


// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");

  // 地図の中心と倍率は公式から変更しています。
  map = new Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 10,
    mapTypeControl: false
  });

  fetch('/users.json')
    .then((res) => {
      if (res.ok) {
        return res.json()
      }
    })
    .then((data) => {
      const items = data.data.items
      items.forEach((item) => {
        const marker = new google.maps.Marker({
          position: new google.maps.LatLng(item.latitude, item.longitude),
          map,
          title: item.name,
        });
        const information = new google.maps.InfoWindow({
          content: `
            <div class="information container p-0">
              <div class="mb-3">
                <img class="thumbnail" src="${item.profile_image}" loading="lazy">
              </div>
              <div>
                <h1 class="h4 font-weight-bold">${item.name}</h1>
                <p class="text-muted">${item.address}</p>
              </div>
            </div>
          `,
          ariaLabel: item.shop_name,
        });

        marker.addListener("click", () => {
          information.open({
            anchor: marker,
            map,
          })
        })
      });
    })
    .catch(error => console.error(error))
}

initMap()