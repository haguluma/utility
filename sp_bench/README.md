## めも
utility/spbench/sm.shはcgroupモニタリングをロギングする(start_monitering)。動かすのに管理者権限が必要  
```
$ cd ~/utility/spbench
$ sudo ./sm.sh
```
モニタリングが終わったらkillしてね

utility/cn_proc/mv_procは監視するプロセスのフックと移動に使っている  
utility/cp_tcg.shはmemory_ctlからcpu_ctlへのプロセスのコピーに使っている。これは複数のcgroupにプロセスを配置できないcn_procのバグ(?)への対応  
上の二つはモニタリングを始める前にバックグラウンドで動かしておこう

準備ができたらutility/spbench/start.shでベンチマークを開始する  

何かおかしければutility/watch.shはctl_memory,ctl_cpu(コントロールグループ)内のプロセスを1秒置きに確認する




