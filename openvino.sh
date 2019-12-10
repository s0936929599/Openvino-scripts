#!/bin/bash

#Programming by Axiomtek Colin 2019/10/09 YOLOV3 done!

#Programming by Axiomtek Colin 2019/10/14 text_detection_demo done!

#Programming by Axiomtek Colin 2019/10/25 bench_mark_app done!

#Programming by Axiomtek Colin 2019/11/08 add VPU device plugin!

#Choose Application

echo "|-----------------Here is the Applications--------------|"
echo "|1.crossroad_camera_demo                                |"
echo "|2.gaze_estimation_demo                                 |"
echo "|3.human_pose_estimation_demo                           |"
echo "|4.interactive_face_detection_demo                      |"
echo "|5.object_detection_demo_yolov3_async                   |"
echo "|6.text_detection_demo                                  |"
echo "|7.benchmark_app                                        |"
echo "|8.save_vpu_output                                      |"
echo "|-------------------------------------------------------|"

read -p "Please choose a number of application "$'\n' n_app

export env1="/opt/intel/openvino/bin/setupvars.sh"
export desktop="/home/colin/桌面"

app_array=([1]="crossroad_camera_demo" [2]="gaze_estimation_demo" [3]="human_pose_estimation_demo" 
[4]="interactive_face_detection_demo" [5]="object_detection_demo_yolov3_async" 
[6]="text_detection_demo" [7]="benchmark_app" [8]="save_vpu_output")


printf "your choose is \n${app_array[$n_app]} \n"

###---------5.object_detection_demo_yolov3_async----------###

if [ ${n_app} == "5" ];then

echo ""

read -p "Please choose a video or image (default a video (type 1)) "$'\n' im 

read -p "Please choose your Inference Engine  1.CPU(FP32) 2.GPU(FP16) 3.VPU(FP16) 4.FPGA(FP11)"$'\n' hd

if [ ${im} == "1" ];then

#im="/home/colin/桌面/OpenVINO-YoloV3-master/1.mp4"
im="/home/colin/桌面/1030/1030.mp4"


fi 

if [ ${hd} == "FPGA" ] || [ ${hd} == "4" ];then

export AOCL_BOARD_PACKAGE_ROOT=/opt/intel/openvino/bitstreams/a10_vision_design_sg1_bitstreams/BSP/a10_1150_sg1/

export QUARTUS_ROOTDIR=/home/colin/intelFPGA/18.1/qprogrammer

export PATH=$PATH:/opt/altera/aocl-pro-rte/aclrte-linux64/bin:/opt/altera/aocl-pro-rte/aclrte-linux64/host/linux64/bin:/home/colin/intelFPGA/18.1/qprogrammer/bin

export INTELFPGAOCLSDKROOT=/opt/altera/aocl-pro-rte/aclrte-linux64

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AOCL_BOARD_PACKAGE_ROOT/linux64/lib

export CL_CONTEXT_COMPILER_MODE_INTELFPGA=3

source /opt/altera/aocl-pro-rte/aclrte-linux64/init_opencl.sh

source /opt/intel/openvino/bin/setupvars.sh

#/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP32/frozen_darknet_yolov3_model.xml -d HETERO:FPGA,CPU 
#/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/yolov3_pcb.xml -d HETERO:FPGA,CPU 
/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP32/yolov3_v2_pcb.xml -d HETERO:FPGA,CPU 

elif [ ${hd} == "VPU" ] || [ ${hd} == "3" ];then
source ${env1}
#/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/frozen_darknet_yolov3_model.xml -d HETERO:HDDL,CPU
#/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/yolov3_pcb.xml -d GPU
/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/yolov3_v2_pcb.xml -d HDDL
elif [ ${hd} == "GPU" ] || [ ${hd} == "2" ];then
source ${env1}
/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/frozen_darknet_yolov3_model.xml -d GPU
#/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/yolov3_pcb.xml -d GPU
#/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP16/yolov3_v2_pcb.xml -d GPU
elif [ ${hd} == "CPU" ] || [ ${hd} == "1" ];then
source ${env1}
/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP32/frozen_darknet_yolov3_model.xml
#/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP32/yolov3_pcb.xml 

#/home/colin/omz_demos_build/intel64/Release/object_detection_demo_yolov3_async -i $im -m /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP32/yolov3_v2_pcb.xml
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
[6]="squeezenet1.0" [7]="squeezenet1.1" [8]="mobilenet-v1-0.25-128" [9]="mobilenet-v1-0.50-160" 
[10]="mobilenet-v1-0.50-224" [11]="mobilenet-v1-1.0-224" [12]="mobilenet-v2" 
[13]="mobilenet-v2-1.0-224" [14]="mobilenet-v2-1.4-224" 
[15]="resnet-50" [16]="resnet-101" [17]="resnet-152" 
[18]="vgg16" [19]="vgg19" 
[20]="ssd300" [21]="ssd512" [22]="yolov3")

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
echo "|8.mobilenet-v1-0.25-128                                |"
echo "|9.mobilenet-v1-0.50-160                                |"
echo "|10.mobilenet-v1-0.50-224                               |"
echo "|11.mobilenet-v1-1.0-224                                |"
echo "|12.mobilenet-v2                                        |"
echo "|13.mobilenet-v2-1.0-224                                |"
echo "|14.mobilenet-v2-1.4-224                                |"
echo "|15.resnet-50                                           |"
echo "|16.resnet-101                                          |"
echo "|17.resnet-152                                          |"
echo "|18.vgg16                                               |"
echo "|19.vgg19                                               |"
echo "|20.ssd300                                              |"
echo "|21.ssd512                                              |"
echo "|22.yolov3                                              |"
echo "|-------------------------------------------------------|"


read -p "Please choose a number of model "$'\n' num_application

printf "your choose is \n${application[$num_application]} \n"

read -p "Please choose your Precision  1.FP32 2.FP16 3.FP11(only on FPGA)"$'\n' precision

if [ ${precision} == "1" ] || [ ${precision} == "FP32" ];then

read -p "Please choose your Inference Engine  1.CPU 2.GPU "$'\n' hd

elif [ ${precision} == "2" ] || [ ${precision} == "FP16" ];then

read -p "Please choose your Inference Engine  1.CPU 2.GPU 3.FPGA 4.VPU"$'\n' hd

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

elif [ ${precision} == "2" ] && [ ${hd} == "4" ];then
precision=FP16
hd=VPU

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


elif [ ${precision} == "FP16" ] && [ ${hd} == "VPU" ] ;then

source ${env1}

printf "${application[$num_application]} \n ${precision} \n $hd "
/home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/${application[$num_application]}/${precision}/${application[$num_application]}.xml -niter 1000 -nireq 32 -d HDDL



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

read -p "Continue (type 0) or Exit (others) "$'\n' cotue

done

fi




###------------------8.save_benchmark_to_txt----------------------###

if [ ${n_app} == "8" ];then

clear

application=([1]="alexnet" [2]="googlenet-v1" [3]="googlenet-v2" 
[4]="googlenet-v3" [5]="googlenet-v4" 
[6]="squeezenet1.0" [7]="squeezenet1.1" [8]="mobilenet-v1-0.25-128" [9]="mobilenet-v1-0.50-160" 
[10]="mobilenet-v1-0.50-224" [11]="mobilenet-v1-1.0-224" [12]="mobilenet-v2" 
[13]="mobilenet-v2-1.0-224" [14]="mobilenet-v2-1.4-224" 
[15]="resnet-50" [16]="resnet-101" [17]="resnet-152" 
[18]="vgg16" [19]="vgg19" 
[20]="ssd300" [21]="ssd512" [22]="yolov3")

#script output.txt

for i in "${application[@]}"
   # FP32 CPU
   do 
   /home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/$i/FP32/$i.xml -niter 1000 -nireq 32 -d CPU
   done
for i in "${application[@]}"
   # FP32 GPU
   do 
   /home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/$i/FP32/$i.xml -niter 1000 -nireq 32 -d GPU
   done

for i in "${application[@]}"
    #FP16 CPU
   do 
   /home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/$i/FP16/$i.xml -niter 1000 -nireq 32 -d CPU
   done

for i in "${application[@]}"
   # FP16 GPU
   do 
   /home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/$i/FP16/$i.xml -niter 1000 -nireq 32 -d GPU
   done

#for i in "${application[@]}"
   # FP16 VPU
  # do 
   #/home/colin/inference_engine_samples_build/intel64/Release/benchmark_app -m /home/colin/桌面/model/mo_public/public/$i/FP16/$i.xml -niter 1000 -nireq 48 -d HDDL
   #done


fi
###---------------------------------------------------------------###
exit 0






#5.gaze estimation
#6.face detection
#7.human pose detection
#8.Crossroad Camera

#9.text detection
#10.Security Barrier Camera







#1.yolov3--------------------------------
#/home/colin/omz_demos_build_1/intel64/Release/multi_channel_object_detection_demo_yolov3 -i /home/colin/桌面/OpenVINO-YoloV3-master/1.mp4 -m  /home/colin/桌面/OpenVINO-YoloV3-master/lrmodels/YoloV3/FP32/frozen_darknet_yolov3_model.xml -d HDDL
#--------------------------------------

#2.face detection -----------------------ok
#./interactive_face_detection_demo -m '/home/colin/桌面/model/intel/face-detection-adas-0001/FP32/face-detection-adas-0001.xml' -m_ag '/home/colin/桌面/model/intel/age-gender-recognition-retail-0013/FP32/age-gender-recognition-retail-0013.xml' -i cam -m_em '/home/colin/桌面/model/intel/emotions-recognition-retail-0003/FP32/emotions-recognition-retail-0003.xml' 
#--------------------------------------

#3.human pose detection------------------ok
#./human_pose_estimation_demo -m '/home/colin/桌面/model/intel/human-pose-estimation-0001/FP32/human-pose-estimation-0001.xml'
#--------------------------------------


#4.Crossroad Camera----------------------ok
#./crossroad_camera_demo -m '/home/colin/桌面/model/intel/person-vehicle-bike-detection-crossroad-0078/FP32/person-vehicle-bike-detection-crossroad-0078.xml'  -i '/home/colin/桌面/OpenVINO-YoloV3-master/v.mp4'  -m_pa '/home/colin/桌面/model/intel/person-attributes-recognition-crossroad-0230/FP32/person-attributes-recognition-crossroad-0230.xml' 
#-m_reid '/home/colin/桌面/model/intel/person-reidentification-retail-0079/FP32/person-reidentification-retail-0079.xml'
#--------------------------------------

#5.Security Barrier Camera----------------ok
#./security_barrier_camera_demo -m '/home/colin/桌面/model/intel/vehicle-license-plate-detection-barrier-0106/FP32/vehicle-license-plate-detection-barrier-0106.xml' -i '/opt/intel/openvino/deployment_tools/demo/car_1.bmp' -m_va '/home/colin/桌面/model/intel/vehicle-attributes-recognition-barrier-0039/FP32/vehicle-attributes-recognition-barrier-0039.xml' -m_lpr '/home/colin/桌面/model/intel/license-plate-recognition-barrier-0001/FP32/license-plate-recognition-barrier-0001.xml'
#---------------------------------------

#6.text_detection_demo------------------ok
#./text_detection_demo -m_td '/home/colin/桌面/model/intel/text-detection-0003/FP32/text-detection-0003.xml' -m_tr '/home/colin/桌面/model/intel/text-recognition-0012/FP32/text-recognition-0012.xml' -i '/home/colin/桌面/1.png' -dt image

#./text_detection_demo -m_td '/home/colin/桌面/model/intel/text-detection-0003/FP32/text-detection-0003.xml' -m_tr '/home/colin/桌面/model/intel/text-recognition-0012/FP32/text-recognition-0012.xml'  -dt webcam -i /dev/video0
#---------------------------------------

#7.Pedestrian Tracker-------------------
#./pedestrian_tracker_demo -m_det '/home/colin/桌面/model/intel/person-detection-retail-0013/FP32/person-detection-retail-0013.xml'  -m_reid '/home/colin/桌面/model/intel/person-reidentification-retail-0031/FP32/person-reidentification-retail-0031.xml' -i '/home/colin/桌面/store-aisle-detection.mp4'
#---------------------------------------

#8.Smart classroom----------------------
#./smart_classroom_demo -i '/home/colin/桌面/classroom.mp4' -m_act '/home/colin/桌面/model/intel/person-detection-action-recognition-0005/FP32/person-detection-action-recognition-0005.xml'   -m_fd '/home/colin/桌面/model/intel/face-detection-adas-0001/FP32/face-detection-adas-0001.xml'   -m_reid '/home/colin/桌面/model/intel/face-reidentification-retail-0095/FP32/face-reidentification-retail-0095.xml'  -m_lm '/home/colin/桌面/model/intel/landmarks-regression-retail-0009/FP32/landmarks-regression-retail-0009.xml'
#---------------------------------------

#9.gaze estimation----------------------ok
#./gaze_estimation_demo -m '/home/colin/桌面/model/intel/gaze-estimation-adas-0002/FP32/gaze-estimation-adas-0002.xml' -m_fd '/home/colin/桌面/model/intel/face-detection-retail-0004/FP32/face-detection-retail-0004.xml'   -m_hp '/home/colin/桌面/model/intel/head-pose-estimation-adas-0001/FP32/head-pose-estimation-adas-0001.xml'  -m_lm '/home/colin/桌面/model/intel/facial-landmarks-35-adas-0002/FP32/facial-landmarks-35-adas-0002.xml' -i '/home/colin/桌面/head-pose-face-detection-female.mp4'
#---------------------------------------

#.python segmentation ------------------
#python3 '/opt/intel/openvino/inference_engine/demos/python_demos/segmentation_demo/segmentation_demo.py'  -i '/home/colin/桌面/93b55a45c1fd5d61.jpg'  -m '/home/colin/桌面/model/intel/semantic-segmentation-adas-0001/FP32/semantic-segmentation-adas-0001.xml' -l '/opt/intel/openvino/deployment_tools/inference_engine/lib/intel64/libcpu_extension_avx2.so'
#----------------------------------


#.python classification-----------------
#python3 '/opt/intel/openvino/inference_engine/samples/python_samples/classification_sample/classification_sample.py' -m '/home/colin/桌面/model/mo_public/public/alexnet/FP32/alexnet.xml' -i '/opt/intel/openvino/deployment_tools/demo/car_1.bmp' --labels '/home/colin/桌面/model/mo_public/public/alexnet/FP32/alexnet.labels' -nt 1
#--------------------------------------


#.python instance_segmentation---------
#python3 '/opt/intel/openvino/inference_engine/demos/python_demos/instance_segmentation_demo/instance_segmentation_demo.py' -m '/home/colin/桌面/model/intel/instance-segmentation-security-0050/FP32/instance-segmentation-security-0050.xml' --labels '/opt/intel/openvino/inference_engine/demos/python_demos/instance_segmentation_demo/coco_labels.txt' -i 0 -l '/opt/intel/openvino/deployment_tools/inference_engine/lib/intel64/libcpu_extension_avx2.so' --no_keep_aspect_ratio     --delay 1
#--------------------------------------


#Action Recognition--------------------
#python3 action_recognition.py -m_en '/home/colin/桌面/model/intel/driver-action-recognition-adas-0002-encoder/FP32/driver-action-recognition-adas-0002-encoder.xml'  -m_de '/home/colin/桌面/model/intel/driver-action-recognition-adas-0002-decoder/FP32/driver-action-recognition-adas-0002-decoder.xml' -i 0 -lb '/opt/intel/openvino/inference_engine/demos/python_demos/action_recognition/driver_actions.txt'
#--------------------------------------
