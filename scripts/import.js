const fetch = require("node-fetch");
const NAMES = ["continentes", "lik03", "test"];
const AUDIOSETS = NAMES.map(name =>
  require(`./import/data/${name}.audioset.json`)
);
const isProduction = false;
const URL = isProduction
  ? "https://atpls-share.herokuapp.com"
  : "http://localhost:3000";

const audiosetData = audioset => ({
  name: audioset.meta.title + (isProduction ? "" : Date.now()),
  description: audioset.meta.description,
  readme: audioset.meta.readme
});

const trackData = track => ({
  name: track.id,
  position: track.num,
  color: track.color,
  volume: 1
});

const clipData = clip => ({
  name: clip.id,
  title: clip.title,
  album: clip.album,
  artist: clip.artist,
  year: clip.year,
  country: clip.country,
  xpos: clip.lnglat[0],
  ypos: clip.lnglat[1],
  readme: "",
  color: clip.display.color,
  key: clip.keyboard,
  beats: clip.audio.beats,
  volume: clip.audio.volume
});

const BASE_URL = "https://antropoloops.github.io/audiosets";
const mediaUrl = (type, audioset, clip, extension) =>
  `${BASE_URL}/${audioset.id}/${type}/${clip.id}.${extension}`;

const mediaData = (audioset, clip) => ({
  cover_url: mediaUrl("covers", audioset, clip, "jpg"),
  audio_mp3_url: mediaUrl("audio", audioset, clip, "mp3"),
  audio_wav_url: mediaUrl("audio", audioset, clip, "wav")
});

main();

async function main() {
  console.log(`Import into ${URL}`);
  for (let audioset of AUDIOSETS) {
    await importAudioset(audioset);
  }
}

async function importAudioset(audioset) {
  console.log(`Audioset ${audioset.id}`);

  const response = await post("/import/audioset", {
    audioset: audiosetData(audioset)
  });
  for (let track of audioset.tracks) {
    await importTrack(response.id, track, audioset);
  }
}

async function importTrack(audiosetId, track, audioset) {
  console.log(`Track ${track.id}`);

  const response = await post("/import/track", {
    audioset_id: audiosetId,
    track: trackData(track)
  });
  for (let clipName of track.clipIds) {
    await importClip(
      audiosetId,
      response.id,
      audioset.clips[clipName],
      audioset
    );
  }
}

async function importClip(audiosetId, trackId, clip, audioset) {
  console.log(`Import clip ${clip.id} to ${audiosetId}`);

  const response = await post("/import/clip", {
    audioset_id: audiosetId,
    track_id: trackId,
    clip: clipData(clip)
  });
  await post("/import/media", {
    clip_id: response.id,
    ...mediaData(audioset, clip)
  });
  console.log("clip", response.id);
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
