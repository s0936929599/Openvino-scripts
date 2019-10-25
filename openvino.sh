#!/bin/bash

#Programming by Axiomtek Colin 2019/10/09 YOLOV3 done!

#Programming by Axiomtek Colin 2019/10/14 text_detection_demo done!

#Programming by Axiomtek Colin 2019/10/25 bench_mark_app done!

#Choose Application

echo "|-----------------Here is the Applications--------------|"
echo "|1.crossroad_camera_demo                                |"
echo "|2.gaze_estimation_demo                                 |"
echo "|3.human_pose_estimation_demo                           |"
echo "|4.interactive_face_detection_demo                      |"
echo "|5.object_detection_demo_yolov3_async                   |"
echo "|6.text_detection_demo                                  |"
echo "|7.benchmark_app                                        |"
echo "|-------------------------------------------------------|"

read -p "Please choose a number of application "$'\n' n_app

export env1="/opt/intel/openvino/bin/setupvars.sh"
export desktop="/home/colin/桌面"

app_array=([1]="crossroad_camera_demo" [2]="gaze_estimation_demo" [3]="human_pose_estimation_demo" 
[4]="interactive_face_detection_demo" [5]="object_detection_demo_yolov3_async" 
[6]="text_detection_demo" [7]="benchmark_app")


printf "your choose is \n${app_array[$n_app]} \n"

###---------5.object_detection_demo_yolov3_async----------###

if [ ${n_app} == "5" ];then

echo ""

read -p "Please choose a video or image (default a video (type 1)) "$'\n' im 

read -p "Please choose your Inference Engine  1.CPU(FP32) 2.GPU(FP16) 3.FPGA(FP11)"$'\n' hd

if [ ${im} == "1" ];then

im="/home/colin/桌面/OpenVINO-YoloV3-master/1.mp4"

fi 

if [ ${hd} == "FPGA" ] || [ ${hd} == "3" ];then

export AOCL_BOARD_PACKAGE_ROOT=/opt/intel/openvino/bitstreams/a10_vision_design_sg1_bitstreams/BSP/a10_1150_sg1/

export QUARTUS_ROOTDIR=/home/colin/intelFPGA/18.1/qprogrammer

export PATH=$PATH:/opt/altera/aocl-pro-rte/aclrte-linux64/bin:/opt/altera/aocl-pro-rte/aclrte-linux64/host/linux64/bin:/home/colin/intelFPGA/18.1/qprogrammer/bin

export INTELFPGAOCLSDKROOT=/opt/altera/aocl-pro-rte/aclrte-linux64

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AOCL_BOARD_PACKAGE_ROOT/linux64/lib

export CL_CONTEXT_COMPILER_MODE_INTELFPGA=3

source /opt/altera/aocl-pro-rte/aclrte-linux64/init_opencl.sh

source /opt/intel/openvino/bin/setupvars.sh

/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/frozen_darknet_yolov3_model.xml -d HETERO:FPGA,CPU

elif [ ${hd} == "GPU" ] || [ ${hd} == "2" ];then
source ${env1}
/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/frozen_darknet_yolov3_model.xml -d GPU

elif [ ${hd} == "CPU" ] || [ ${hd} == "1" ];then
source ${env1}
/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP32/frozen_darknet_yolov3_model.xml

else
 echo "Please choose Inference Engine correctly"

fi
fi
###-------------------------------------------------------###



###---------------6.text_detection_demo-----------------###
if [ ${n_app} == "6" ];then

echo ""

read -p "Please choose your data type(1.image or 2.video) "$'\n' im_type

read -p "Please choose an image or video (default a image (type 1)) "$'\n' im 

read -p "Please choose your Inference Engine  1.CPU(FP32) 2.GPU(FP16) "$'\n' hd

if [ ${im_type} == "1" ] || [ ${im_type} == "image" ];then

im_type="image"

elif [ ${im_type} == "2" ] || [ ${im_type} == "video" ];then

im_type="video"
fi 

if [ ${im} == "1" ];then

im="/home/colin/桌面/1.png"

fi 

if [ ${hd} == "GPU" ] || [ ${hd} == "2" ];then
source ${env1}
/home/colin/omz_demos_build/intel64/Release/text_detection_demo  -i $im -m_tr /home/colin/桌面/model/intel/text-recognition-0012/FP16/text-recognition-0012.xml -m_td /home/colin/桌面/model/intel/text-detection-0004/FP16/text-detection-0004.xml -d_td GPU -d_tr CPU -dt $im_type
elif [ ${hd} == "CPU" ] || [ ${hd} == "1" ];then
source ${env1}

/home/colin/omz_demos_build/intel64/Release/text_detection_demo  -i $im -m_tr /home/colin/桌面/model/intel/text-recognition-0012/FP32/text-recognition-0012.xml -m_td /home/colin/桌面/model/intel/text-detection-0004/FP32/text-detection-0004.xml -d_td CPU -d_tr CPU -dt $im_type

else
 echo "Please choose Inference Engine correctly"

fi
fi
###-------------------------------------------------------###

###------------------7.benchmark_app----------------------###
if [ ${n_app} == "7" ];then

clear
application=([1]="alexnet" [2]="googlenet-v1" [3]="googlenet-v2" 
[4]="googlenet-v3" [5]="googlenet-v4" 
[6]="squeezenet1.0" [7]="squeezenet1.1")


cotue=0 

while [ $cotue == 0 ]

do

echo "|-----------------Here is the Models--------------------|"
echo "|1.alexnet                                              |"
echo "|2.googlenet-v1                                         |"
echo "|3.googlenet-v2                                         |"
echo "|4.googlenet-v3                                         |"
echo "|5.googlenet-v4                                         |"
echo "|6.squeezenet1.0                                        |"
echo "|7.squeezenet1.1                                        |"
echo "|                                                       |"
echo "|-------------------------------------------------------|"


read -p "Please choose a number of model "$'\n' num_application

printf "your choose is \n${application[$num_application]} \n"

read -p "Please choose your Precision  1.FP32 2.FP16 3.FP11(only on FPGA)"$'\n' precision

if [ ${precision} == "1" ] || [ ${precision} == "FP32" ];then

read -p "Please choose your Inference Engine  1.CPU 2.GPU "$'\n' hd

elif [ ${precision} == "2" ] || [ ${precision} == "FP16" ];then

read -p "Please choose your Inference Engine  1.CPU 2.GPU 3.FPGA "$'\n' hd

fi

if [ ${precision} == "1" ] && [ ${hd} == "1" ];then
precision=FP32
hd=CPU

elif [ ${precision} == "1" ] && [ ${hd} == "2" ];then
precision=FP32
hd=GPU

elif [ ${precision} == "2" ] && [ ${hd} == "1" ];then
precision=FP16
hd=CPU

elif [ ${precision} == "2" ] && [ ${hd} == "2" ];then
precision=FP16
hd=GPU

elif [ ${precision} == "2" ] && [ ${hd} == "3" ];then
precision=FP16
hd=FPGA

elif [ ${precision} == "3" ];then
precision=FP11
hd=FPGA

fi

printf "precision = $precision\n"
printf "Inference Engine = $hd\n"


if [ ${precision} == "FP32" ];then

source ${env1}

printf "${application[$num_application]} \n ${precision} \n $hd "
/home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/${application[$num_application]}/${precision}/${application[$num_application]}.xml -niter 1000 -nireq 16 -d $hd

elif [ ${precision} == "FP16" ] && [ ${hd} == "CPU" ] ;then

source ${env1}

printf "${application[$num_application]} \n ${precision} \n $hd "
/home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/${application[$num_application]}/${precision}/${application[$num_application]}.xml -niter 1000 -nireq 16 -d $hd

elif [ ${precision} == "FP16" ] && [ ${hd} == "GPU" ] ;then

source ${env1}

printf "${application[$num_application]} \n ${precision} \n $hd "
/home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/${application[$num_application]}/${precision}/${application[$num_application]}.xml -niter 1000 -nireq 16 -d $hd

elif [ ${precision} == "FP16" ] && [ ${hd} == "FPGA" ];then

printf "${application[$num_application]} \n ${precision} \n $hd "

export AOCL_BOARD_PACKAGE_ROOT=/opt/intel/openvino/bitstreams/a10_vision_design_sg1_bitstreams/BSP/a10_1150_sg1/

export QUARTUS_ROOTDIR=/home/colin/intelFPGA/18.1/qprogrammer

export PATH=$PATH:/opt/altera/aocl-pro-rte/aclrte-linux64/bin:/opt/altera/aocl-pro-rte/aclrte-linux64/host/linux64/bin:/home/colin/intelFPGA/18.1/qprogrammer/bin

export INTELFPGAOCLSDKROOT=/opt/altera/aocl-pro-rte/aclrte-linux64

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AOCL_BOARD_PACKAGE_ROOT/linux64/lib

export CL_CONTEXT_COMPILER_MODE_INTELFPGA=3

source /opt/altera/aocl-pro-rte/aclrte-linux64/init_opencl.sh

source /opt/intel/openvino/bin/setupvars.sh

printf "${application[$num_application]} \n ${precision} \n $hd "

/home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/${application[$num_application]}/${precision}/${application[$num_application]}.xml -niter 1000 -nireq 16 -d HETERO:FPGA,CPU

elif [ ${precision} == "FP11" ];then

export AOCL_BOARD_PACKAGE_ROOT=/opt/intel/openvino/bitstreams/a10_vision_design_sg1_bitstreams/BSP/a10_1150_sg1/

export QUARTUS_ROOTDIR=/home/colin/intelFPGA/18.1/qprogrammer

export PATH=$PATH:/opt/altera/aocl-pro-rte/aclrte-linux64/bin:/opt/altera/aocl-pro-rte/aclrte-linux64/host/linux64/bin:/home/colin/intelFPGA/18.1/qprogrammer/bin

export INTELFPGAOCLSDKROOT=/opt/altera/aocl-pro-rte/aclrte-linux64

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AOCL_BOARD_PACKAGE_ROOT/linux64/lib

export CL_CONTEXT_COMPILER_MODE_INTELFPGA=3

source /opt/altera/aocl-pro-rte/aclrte-linux64/init_opencl.sh

source /opt/intel/openvino/bin/setupvars.sh

/home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/${application[$num_application]}/FP16/${application[$num_application]}.xml -niter 1000 -nireq 16 -d HETERO:FPGA,CPU
fi

read -p "Continue (type 0) or Exit (type 1) "$'\n' cotue

done



fi

















exit 0 
