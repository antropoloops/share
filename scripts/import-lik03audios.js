const fetch = require("node-fetch");
const DEV = require("./dev.json");
const PROD = require("./prod.json");

const isProduction = false;
const URL = isProduction
  ? "https://atpls-share.herokuapp.com"
  : "http://localhost:3000";

const DATA = isProduction ? PROD : DEV;
const clips = DATA.map(d => ({ id: d.id, slug: d.slug }));
const BASE_URL = "https://antropoloops.github.io/audiosets";
const mediaUrl = (type, audioset, clip, extension) =>
  `${BASE_URL}/${audioset}/${type}/${clip}.${extension}`;

main();

async function main() {
  const cs = clips;
  for (let clip of cs) {
    const data = {
      clip_id: clip.id,
      audio_wav_url: mediaUrl("audio", "lik03", clip.slug, "wav"),
      audio_mp3_destroy: "true"
    };
    console.log(clip, data);
    await post("/import/media", data);
  }
}

async function post(path, data) {
  const response = await fetch(`${URL}${path}`, {
    method: "POST",
    body: JSON.stringify(data),
    headers: {
      "Content-Type": "application/json"
    },
    credentials: "same-origin"
  });
  return await response.json();
}
