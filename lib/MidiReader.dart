import 'dart:io';
import 'package:dart_midi/dart_midi.dart';

class MidiReader {
  MidiFile? midi_object;
  File? midi_file;
  final int playback_speed = 0;
}

// midi_file = input("Midi file name (without suffix)")
// midi_object = MidiFile("./songs/" + midi_file + ".mid")
// try:
// 	midi_object = MidiFile("./songs/" + midi_file + ".mid")
// except:
// 	print("The file is damaged or does not exist.")
// 	quit()
// tick_accuracy = 0
// print("Try to calculate the playback speed...")
// try:
// 	bpm = 60000000 / midi_object.tracks[1][0].tempo
// 	tick_accuracy = bpm / 20
// 	print("The calculation is successful.")
// except:
// 	tick_accuracy = int(input("The calculation failed, please check whether the file is complete, or manually enter the playback speed: (7)"))
// type = ['note_on','note_off']
// tracks = []
// end_track = []
// print("Start reading the audio track.")
// for i,track in enumerate(midi_object.tracks):
// 	print(f'track{i}')
// 	last_time = 0
// 	last_on = 0
// 	for msg in track:
// 		info = msg.dict()
// 		info['pertime'] = info['time']
// 		info['time'] += last_time
// 		last_time = info['time']
// 		if (info['type'] in type):
// 			del info['channel']
// 			del info['velocity']
// 			info['time'] = round(info['time'] / tick_accuracy)
// 			if info['type'] == 'note_on':
// 				del info['type']
// 				del info['pertime']
// 				last_on = info['time']
// 				tracks.append(info)
// 			else:
// 				del info['type']
// 				del info['pertime']
// 				last_on = info['time']
// 				end_track.append(info)
// mmax = 0
// for i in end_track:
// 	mmax = max(mmax, i['time'] + 1)
// start = {}
// print("Start converting the score...")
// for i in range(mmax):
// 	start[str(i)] = find(tracks, i)
