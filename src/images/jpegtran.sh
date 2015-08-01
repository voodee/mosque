#!/bin/sh.

    DIR=$1;
    DIR=`echo $1 |sed -e 's,\(.\)/$,\1,'`

    back() {
    mkdir "$DIR.old";
    for i in `ls $DIR`;
    do
    cp $DIR/$i $DIR.old;
    done;
    echo "Your files copied to $DIR.old...."
    }

    tran() {
    echo "Start OPTIMIZING...."
    for file
    in `find $DIR -iname "*.jpg" -or -iname "*.png" -or -iname "*.jpeg"`;
    do
     ext=${file##*.}
        if [ -n "$ext" ]; then
      if [ "$ext" = "jpg" ]; then
         echo "optimizing ${file} as jpeg file with jpegtran"
          jpegtran -copy none -optimize -perfect -outfile temp_file.jpg $file
          mv -f temp_file.jpg $file;
        fi
        if [ "$ext" = "jpeg" ]; then
              echo "optimizing ${file} as jpeg file with jpegtran"
              jpegtran -copy none -optimize -perfect -outfile temp_file.jpeg $file
             mv -f temp_file.jpeg $file;
        fi
        if [ "$ext" = "png" ]; then
           echo "optimizing ${file} as png file with pngcrush"
           pngcrush -rem alla -reduce -brute "$file" temp_file.png;
            mv -f temp_file.png $file;
         fi
        fi
    done;
      echo "OPTIMIZE IS DONE!";
      echo "You can find your files before optimization in $DIR.old"
    }

    dojob() {
    if [ -z "$DIR" ]
    then
    echo "Script usage: ./tran.sh /dirname"
    exit 1
    else
    back
    tran
    fi
    }

    echo "Script is starting...."
    dojob
    echo "Script job finished"
    exit 0