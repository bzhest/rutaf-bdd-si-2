package com.refinitiv.asts.test.ui.utils;


import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;


public class StringSorter {


    public String[] sortArray( String[] stringArr ) {

        Arrays.sort( stringArr, new Comparator<String>() {

                                    @Override
                                    public int compare( String s1, String s2 ) {
                                        if ( s1==null && s2==null ) {
                                            return 0;
                                        }
                                        if ( s1==null && s2!=null ) {
                                            return -1;
                                        }
                                        if ( s1!=null && s2==null ) {
                                            return 1;
                                        }
                                        // s1!=null && s2!=null
                                        return s1.compareToIgnoreCase( s2 );
                                    }
                                }
               );

        return stringArr;
    }


    public String[] reverseSortArray( String[] stringArr ) {

        return null;
    }


    public List<String> sortList( List<String> stringList ) {

        Collections.sort( stringList, new Comparator<String>() {

                                          @Override
                                          public int compare( String s1, String s2 ) {
                                              // System.out.println( "'"+ s1  +"' | '"+ s2 +"'" );
                                              if ( s1==null && s2==null ) {
                                                  return 0;
                                              }
                                              if ( s1==null && s2!=null ) {
                                                  return  -1;
                                              }
                                              if ( s1!=null && s2==null ) {
                                                  return  1;
                                              }
                                              // s1!=null && s2!=null
                                              return s1.compareToIgnoreCase( s2 );
                                          }
                                      }
                    );

        return stringList;
    }


    public List<String> reverseSortList( List<String> stringList ) {

        Collections.sort( stringList, new Comparator<String>() {

                                          @Override
                                          public int compare( String s1, String s2 ) {
                                              // System.out.println( "'"+ s1  +"' | '"+ s2 +"'" );
                                              if ( s1==null && s2==null ) {
                                                  return  0;
                                              }
                                              if ( s1==null && s2!=null ) {
                                                  return  1;
                                              }
                                              if ( s1!=null && s2==null ) {
                                                  return -1;
                                              }
                                              // s1!=null && s2!=null
                                              return -1 * s1.compareToIgnoreCase( s2 );
                                          }
                                      }
                    );

        return stringList;
    }


}
