package com.refinitiv.asts.test.ui.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.*;
import java.lang.invoke.MethodHandles;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

public class ZipFileArchiver {

    private String fqZipArchiveFilename;
    private final static Logger LOGGER = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());

    public ZipFileArchiver() {
    }

    public String archiveToZipFile(String fqZipArchiveFilename, String fqZipEntryFilename) throws IOException {

        this.fqZipArchiveFilename = fqZipArchiveFilename;
        File zipArchiveFile = new File(this.fqZipArchiveFilename);
        if (zipArchiveFile.createNewFile()) {
            LOGGER.info("File '" + this.fqZipArchiveFilename + "' successfully created.");
        } else {
            LOGGER.info("File '" + this.fqZipArchiveFilename + "' already exists.");
        }

        String zipFilename = zipArchiveFile.getName();
        String filenames = new String(zipFilename);

        ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(zipArchiveFile));

        File zipEntryFile = new File(fqZipEntryFilename);
        String zipEntryFilename = zipEntryFile.getName();
        zos.putNextEntry(new ZipEntry(zipEntryFilename));
        byte[] bytes = Files.readAllBytes(Paths.get(fqZipEntryFilename));
        zos.write(bytes, 0, bytes.length);
        zos.closeEntry();
        zos.close();
        filenames.concat(zipEntryFilename);

/*
        FileOutputStream fos = new FileOutputStream( zipArchiveFile );
        ZipOutputStream zos = new ZipOutputStream( fos );

        for ( int i=1; i<fqZipFilenames.length; i++ ) {

            String fqZipFilename = fqZipFilenames[ i ];

            File zipEntryFile = new File( fqZipFilename );
            zos.putNextEntry( new ZipEntry(zipEntryFile.getName()) );
            byte[] bytes = Files.readAllBytes( Paths.get(fqZipFilename) );
            zos.write( bytes, 0, bytes.length );
            zos.closeEntry();

            filenames.concat( " | "+ fqZipFilename );
        }
        zos.close();
*/
        return filenames;
    }

/*
    public static void addFilesToExistingZip( File zipFile, File[] files ) throws IOException {
            // get a temp file
        File tempFile = File.createTempFile( zipFile.getName(), null );
            // delete it, otherwise you cannot rename your existing zip to it.
        tempFile.delete();

        boolean renameOk = zipFile.renameTo( tempFile );
        if ( ! renameOk ) {
            throw new RuntimeException("could not rename the file "+zipFile.getAbsolutePath()+" to "+tempFile.getAbsolutePath());
        }
        byte[] buf = new byte[ 1024 ];

        ZipInputStream  zin = new ZipInputStream(  new FileInputStream( tempFile ) );
        ZipOutputStream out = new ZipOutputStream( new FileOutputStream( zipFile ) );

        ZipEntry entry = zin.getNextEntry();
        while ( entry != null ) {
            String name = entry.getName();
            boolean notInFiles = true;
            for ( File f : files ) {
                if ( f.getName().equals(name) ) {
                    notInFiles = false;
                    break;
                }
            }
            if ( notInFiles ) {
                // Add ZIP entry to output stream.
                out.putNextEntry( new ZipEntry(name) );
                // Transfer bytes from the ZIP file to the output file
                int len;
                while ( (len = zin.read(buf) ) > 0) {
                    out.write( buf, 0, len );
                }
            }
            entry = zin.getNextEntry();
        }
        // Close the streams
        zin.close();

        // Compress the files
        for (int i = 0; i < files.length; i++) {
            InputStream in = new FileInputStream(files[i]);
            // Add ZIP entry to output stream.
            out.putNextEntry(new ZipEntry(files[i].getName()));
            // Transfer bytes from the file to the ZIP file
            int len;
            while ((len = in.read(buf)) > 0) {
                out.write(buf, 0, len);
            }
            // Complete the entry
            out.closeEntry();
            in.close();
        }
        // Complete the ZIP file
        out.close();

        tempFile.delete();
    }
*/

    private File fqZipArchiveFile;

    public void addOrReplaceEntry(String fqZipArchiveFilename, String fqTargetEntryFilename)
            throws IOException {

        if (fqZipArchiveFilename == null) {
            // throw new IllegalArgumentException( "THe fully-qualified path of the zip file can NOT be null." );
        }
        File fqZipArchiveFile = new File(fqZipArchiveFilename);
        Boolean isFile = fqZipArchiveFile.isFile();
        if (!isFile) {
            // throw new IllegalArgumentException( "The fully-qualified path to the zip file does NOT denote a valid file." );
        }
        this.fqZipArchiveFile = fqZipArchiveFile;

        File targetEntryFile = new File(fqTargetEntryFilename);
        String targetEntryFilename = targetEntryFile.getName();
        InputStream targetEntryIs = new FileInputStream(targetEntryFile);

        File tempZipArchiveFile = File.createTempFile(this.fqZipArchiveFile.getName(), null);
        tempZipArchiveFile.delete();
        this.fqZipArchiveFile.renameTo(tempZipArchiveFile);

        ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(this.fqZipArchiveFile));

        this.addOrReplaceEntry(tempZipArchiveFile, targetEntryFilename, targetEntryIs, zos);
        zos.close();
        tempZipArchiveFile.delete();

//        return isFile.toString();
    }

    private void addOrReplaceEntry(File sourceFile, String targetEntryName, InputStream targetEntryIs,
            ZipOutputStream zos)
            throws IOException {

        this.writeZipEntry(zos, targetEntryName, targetEntryIs);

        ZipFile sourceZipFile = new ZipFile(sourceFile);
        Enumeration<? extends ZipEntry> sourceZipEntries = sourceZipFile.entries();
        while (sourceZipEntries.hasMoreElements()) {
            ZipEntry sourceZipEntry = sourceZipEntries.nextElement();
            String sourceZipEntryName = sourceZipEntry.getName();
            if (!targetEntryName.equalsIgnoreCase(sourceZipEntryName)) {

                this.writeZipEntry(zos, sourceZipEntryName, sourceZipFile.getInputStream(sourceZipEntry));
            }
        }
        sourceZipFile.close();
    }

    private void writeZipEntry(ZipOutputStream zos, String entryName, InputStream entryIs)
            throws IOException {

        ZipEntry zipEntry = new ZipEntry(entryName);
        byte[] buffer = new byte[1024];
        zos.putNextEntry(zipEntry);
        int length;
        while ((length = entryIs.read(buffer)) > 0) {
            zos.write(buffer, 0, length);
        }
        zos.closeEntry();
    }

}
