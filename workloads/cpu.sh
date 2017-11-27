for i in {0..9}; do 
    $(while :;do echo 1 > /dev/null; done) & 
done
