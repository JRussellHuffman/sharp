import java.io.File;
import java.util.Arrays;

SoundFile[] backgroundSound;
SoundFile[] foregroundSound;

//provided absolute path to the audio file
File dirFlute = new File("path/to/audio");
File dirStrings= new File("/path/to/audio");

File[] fluteFiles = dirFlute.listFiles();
File[] stringsFiles = dirStrings.listFiles();

void fetchAudio() {

  backgroundSound = new SoundFile[fluteFiles.length];
  foregroundSound = new SoundFile[stringsFiles.length];

  //note: a ds_store may need to be removed to get the correct audio files
  Arrays.sort(stringsFiles);

  //loop through the background audio files, originally stored as flute files
  for ( int i=0; i < fluteFiles.length; i++ ) {
    String path = fluteFiles[i].getAbsolutePath();
    // check the file type and work with jpg/png files
    if ( path.toLowerCase().endsWith(".mp3")) {
      backgroundSound[i] = new SoundFile(this, path);
    }
  }

  //loop through the foreground music files, originally astored as stringed instrument files
  for ( int i=0; i < stringsFiles.length; i++ ) {
    String path = stringsFiles[i].getAbsolutePath();
    if ( path.toLowerCase().endsWith(".wav")) {
      foregroundSound[i] = new SoundFile(this, path);
    }
  }
}
