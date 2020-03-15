if $(test -e test.txt);
  then $(hadoop fs -copyToLocal /user/test.txt test_1.txt);
  else $(hadoop fs -copyToLocal /user/test.txt test.txt);
  fi

if $(hdfs dfs -test -d /user);
  then $(hdfs dfs -touchz /user/test.txt);
  else $(hdfs dfs -mkdir -p /user && hdfs dfs -touchz /user/test.txt);
  fi

if $(hdfs dfs -test -d /user/test1);
  then :;
  else $(hdfs dfs -mkdir -p /user/test1);
  fi

function temp(){
  choice=1; #default delete directory with contents
  printf "This directory is not null, delete it or not? (1-delete,0-not delete)\n";
  read choice;
  if test ${choice} -eq 1;
    then $(hdfs dfs -rm -r /user/test1);
    else :;
    fi
  return 0;
}
if $(hdfs dfs -test -s /user/test1);
  then $(hdfs dfs -rmdir /user/test1);
  else temp;
  fi

if $(hdfs dfs -test -s /user/test1);
  then $(hdfs dfs -rmdir /user/test1);
  else
    choice=1; #default delete directory with contents
    printf "This directory is not null, delete it or not? (1-delete,0-not delete)\n";
    read choice;
    if test ${choice} -eq 1;
      then $(hdfs dfs -rm -r /user/test1);
      else :;
      fi
  fi

function temp(){
  tail=1; #append to tail--1, insert brfore head --0
  printf 'Which position do you expect to put the file ? (0--head, 1--tail)';
  read tail;
  if test ${tail} -eq 1;
    then $(hdfs dfs -appendToFile test.txt /helloWorld.txt);
    else
      $(hdfs dfs -get /helloWorld.txt helloWorld_1.txt);
      $(hdfs dfs -rm /helloWorld.txt);
      $(hdfs dfs -moveFromLocal test.txt /helloWorld.txt);
      $(hdfs dfs -appendToFile helloWorld_1.txt /helloWorld.txt);
      $(rm helloWorld_1.txt);
  fi
}