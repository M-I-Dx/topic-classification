эЧ
нВ
.
Abs
x"T
y"T"
Ttype:

2	
:
Add
x"T
y"T
z"T"
Ttype:
2	
x
Assign
ref"TА

value"T

output_ref"TА"	
Ttype"
validate_shapebool("
use_lockingbool(Ш
B
AssignVariableOp
resource
value"dtype"
dtypetypeИ
k
BatchMatMulV2
x"T
y"T
output"T"
Ttype:

2	"
adj_xbool( "
adj_ybool( 
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
Z
BroadcastTo

input"T
shape"Tidx
output"T"	
Ttype"
Tidxtype0:
2	
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
н
GatherV2
params"Tparams
indices"Tindices
axis"Taxis
output"Tparams"

batch_dimsint "
Tparamstype"
Tindicestype:
2	"
Taxistype:
2	
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
6
MatrixDiagPart

input"T
diagonal"T"	
Ttype
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(И
=
Mul
x"T
y"T
z"T"
Ttype:
2	Р

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
Н
Prod

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
~
RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	И
@
ReadVariableOp
resource
value"dtype"
dtypetypeИ
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0И
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0И
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
0
Sigmoid
x"T
y"T"
Ttype:

2
9
Softmax
logits"T
softmax"T"
Ttype:
2
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	
P
	Transpose
x"T
perm"Tperm
y"T"	
Ttype"
Tpermtype0:
2	
А
TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	И
q
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshapeИ
9
VarIsInitializedOp
resource
is_initialized
И
s

VariableV2
ref"dtypeА"
shapeshape"
dtypetype"
	containerstring "
shared_namestring И"serve*1.15.02v1.15.0-0-g590d6eef7e8╝q

global_step/Initializer/zerosConst*
_output_shapes
: *
value	B	 R *
_class
loc:@global_step*
dtype0	
К
global_stepVarHandleOp*
_output_shapes
: *
shape: *
shared_nameglobal_step*
_class
loc:@global_step*
dtype0	
g
,global_step/IsInitialized/VarIsInitializedOpVarIsInitializedOpglobal_step*
_output_shapes
: 
_
global_step/AssignAssignVariableOpglobal_stepglobal_step/Initializer/zeros*
dtype0	
c
global_step/Read/ReadVariableOpReadVariableOpglobal_step*
dtype0	*
_output_shapes
: 
Й

embeddingsPlaceholder*
dtype0*5
_output_shapes#
!:                  А**
shape!:                  А


input_maskPlaceholder*
dtype0*0
_output_shapes
:                  *%
shape:                  
е
/shared_query/Initializer/truncated_normal/shapeConst*
_output_shapes
:*!
valueB"          *
_class
loc:@shared_query*
dtype0
Ф
.shared_query/Initializer/truncated_normal/meanConst*
valueB
 *    *
_class
loc:@shared_query*
dtype0*
_output_shapes
: 
Ц
0shared_query/Initializer/truncated_normal/stddevConst*
valueB
 *
╫г<*
_class
loc:@shared_query*
dtype0*
_output_shapes
: 
╓
9shared_query/Initializer/truncated_normal/TruncatedNormalTruncatedNormal/shared_query/Initializer/truncated_normal/shape*
T0*
_class
loc:@shared_query*
dtype0* 
_output_shapes
:
 
э
-shared_query/Initializer/truncated_normal/mulMul9shared_query/Initializer/truncated_normal/TruncatedNormal0shared_query/Initializer/truncated_normal/stddev* 
_output_shapes
:
 *
T0*
_class
loc:@shared_query
█
)shared_query/Initializer/truncated_normalAdd-shared_query/Initializer/truncated_normal/mul.shared_query/Initializer/truncated_normal/mean*
_class
loc:@shared_query* 
_output_shapes
:
 *
T0
Б
shared_query
VariableV2*
shape:
 *
_class
loc:@shared_query*
dtype0* 
_output_shapes
:
 
в
shared_query/AssignAssignshared_query)shared_query/Initializer/truncated_normal*
T0*
_class
loc:@shared_query* 
_output_shapes
:
 
w
shared_query/readIdentityshared_query* 
_output_shapes
:
 *
T0*
_class
loc:@shared_query
f
BroadcastTo/shapeConst*!
valueB"   9       *
dtype0*
_output_shapes
:
k
BroadcastToBroadcastToshared_query/readBroadcastTo/shape*
T0* 
_output_shapes
:
9 
г
.class_query/Initializer/truncated_normal/shapeConst*!
valueB"   9      *
_class
loc:@class_query*
dtype0*
_output_shapes
:
Т
-class_query/Initializer/truncated_normal/meanConst*
valueB
 *    *
_class
loc:@class_query*
dtype0*
_output_shapes
: 
Ф
/class_query/Initializer/truncated_normal/stddevConst*
dtype0*
_output_shapes
: *
valueB
 *
╫г<*
_class
loc:@class_query
╓
8class_query/Initializer/truncated_normal/TruncatedNormalTruncatedNormal.class_query/Initializer/truncated_normal/shape*
dtype0*#
_output_shapes
:9А*
T0*
_class
loc:@class_query
ь
,class_query/Initializer/truncated_normal/mulMul8class_query/Initializer/truncated_normal/TruncatedNormal/class_query/Initializer/truncated_normal/stddev*#
_output_shapes
:9А*
T0*
_class
loc:@class_query
┌
(class_query/Initializer/truncated_normalAdd,class_query/Initializer/truncated_normal/mul-class_query/Initializer/truncated_normal/mean*
T0*
_class
loc:@class_query*#
_output_shapes
:9А
Е
class_query
VariableV2*
dtype0*#
_output_shapes
:9А*
shape:9А*
_class
loc:@class_query
б
class_query/AssignAssignclass_query(class_query/Initializer/truncated_normal*
T0*
_class
loc:@class_query*#
_output_shapes
:9А
w
class_query/readIdentityclass_query*#
_output_shapes
:9А*
T0*
_class
loc:@class_query
M
concat/axisConst*
value	B :*
dtype0*
_output_shapes
: 
u
concatConcatV2BroadcastToclass_query/readconcat/axis*
T0*
N*#
_output_shapes
:9А
w
MatMulBatchMatMulV2concat
embeddings*4
_output_shapes"
 :         9         *
adj_y(*
T0
G
sub/yConst*
value	B :*
dtype0*
_output_shapes
: 
X
subSub
input_masksub/y*
T0*0
_output_shapes
:                  
J
AbsAbssub*0
_output_shapes
:                  *
T0
[
CastCastAbs*

SrcT0*0
_output_shapes
:                  *

DstT0
P
ExpandDims/dimConst*
value	B :*
dtype0*
_output_shapes
: 
m

ExpandDims
ExpandDimsCastExpandDims/dim*
T0*4
_output_shapes"
 :                  
J
mul/xConst*
dtype0*
_output_shapes
: *
valueB
 *(knN
\
mulMulmul/x
ExpandDims*4
_output_shapes"
 :                  *
T0
X
sub_1SubMatMulmul*4
_output_shapes"
 :         9         *
T0
X
SoftmaxSoftmaxsub_1*
T0*4
_output_shapes"
 :         9         
e
MatMul_1BatchMatMulV2Softmax
embeddings*,
_output_shapes
:         9А*
T0
Я
-dense/kernel/Initializer/random_uniform/shapeConst*
valueB"   9   *
_class
loc:@dense/kernel*
dtype0*
_output_shapes
:
С
+dense/kernel/Initializer/random_uniform/minConst*
dtype0*
_output_shapes
: *
valueB
 *nзо╜*
_class
loc:@dense/kernel
С
+dense/kernel/Initializer/random_uniform/maxConst*
valueB
 *nзо=*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
: 
═
5dense/kernel/Initializer/random_uniform/RandomUniformRandomUniform-dense/kernel/Initializer/random_uniform/shape*
T0*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
:	А9
╬
+dense/kernel/Initializer/random_uniform/subSub+dense/kernel/Initializer/random_uniform/max+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc:@dense/kernel*
_output_shapes
: 
с
+dense/kernel/Initializer/random_uniform/mulMul5dense/kernel/Initializer/random_uniform/RandomUniform+dense/kernel/Initializer/random_uniform/sub*
T0*
_class
loc:@dense/kernel*
_output_shapes
:	А9
╙
'dense/kernel/Initializer/random_uniformAdd+dense/kernel/Initializer/random_uniform/mul+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc:@dense/kernel*
_output_shapes
:	А9

dense/kernel
VariableV2*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
:	А9*
shape:	А9
Я
dense/kernel/AssignAssigndense/kernel'dense/kernel/Initializer/random_uniform*
_class
loc:@dense/kernel*
_output_shapes
:	А9*
T0
v
dense/kernel/readIdentitydense/kernel*
_output_shapes
:	А9*
T0*
_class
loc:@dense/kernel
И
dense/bias/Initializer/zerosConst*
valueB9*    *
_class
loc:@dense/bias*
dtype0*
_output_shapes
:9
q

dense/bias
VariableV2*
_class
loc:@dense/bias*
dtype0*
_output_shapes
:9*
shape:9
Й
dense/bias/AssignAssign
dense/biasdense/bias/Initializer/zeros*
T0*
_class
loc:@dense/bias*
_output_shapes
:9
k
dense/bias/readIdentity
dense/bias*
T0*
_class
loc:@dense/bias*
_output_shapes
:9
^
dense/Tensordot/axesConst*
_output_shapes
:*
valueB:*
dtype0
e
dense/Tensordot/freeConst*
valueB"       *
dtype0*
_output_shapes
:
M
dense/Tensordot/ShapeShapeMatMul_1*
T0*
_output_shapes
:
_
dense/Tensordot/GatherV2/axisConst*
value	B : *
dtype0*
_output_shapes
: 
╕
dense/Tensordot/GatherV2GatherV2dense/Tensordot/Shapedense/Tensordot/freedense/Tensordot/GatherV2/axis*
Tindices0*
Tparams0*
_output_shapes
:*
Taxis0
a
dense/Tensordot/GatherV2_1/axisConst*
dtype0*
_output_shapes
: *
value	B : 
╝
dense/Tensordot/GatherV2_1GatherV2dense/Tensordot/Shapedense/Tensordot/axesdense/Tensordot/GatherV2_1/axis*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:
_
dense/Tensordot/ConstConst*
_output_shapes
:*
valueB: *
dtype0
n
dense/Tensordot/ProdProddense/Tensordot/GatherV2dense/Tensordot/Const*
T0*
_output_shapes
: 
a
dense/Tensordot/Const_1Const*
valueB: *
dtype0*
_output_shapes
:
t
dense/Tensordot/Prod_1Proddense/Tensordot/GatherV2_1dense/Tensordot/Const_1*
_output_shapes
: *
T0
]
dense/Tensordot/concat/axisConst*
_output_shapes
: *
value	B : *
dtype0
Щ
dense/Tensordot/concatConcatV2dense/Tensordot/freedense/Tensordot/axesdense/Tensordot/concat/axis*
T0*
N*
_output_shapes
:
y
dense/Tensordot/stackPackdense/Tensordot/Proddense/Tensordot/Prod_1*
T0*
N*
_output_shapes
:

dense/Tensordot/transpose	TransposeMatMul_1dense/Tensordot/concat*
T0*,
_output_shapes
:         9А
П
dense/Tensordot/ReshapeReshapedense/Tensordot/transposedense/Tensordot/stack*0
_output_shapes
:                  *
T0
q
 dense/Tensordot/transpose_1/permConst*
_output_shapes
:*
valueB"       *
dtype0
З
dense/Tensordot/transpose_1	Transposedense/kernel/read dense/Tensordot/transpose_1/perm*
_output_shapes
:	А9*
T0
p
dense/Tensordot/Reshape_1/shapeConst*
valueB"   9   *
dtype0*
_output_shapes
:
М
dense/Tensordot/Reshape_1Reshapedense/Tensordot/transpose_1dense/Tensordot/Reshape_1/shape*
T0*
_output_shapes
:	А9
Ж
dense/Tensordot/MatMulMatMuldense/Tensordot/Reshapedense/Tensordot/Reshape_1*
T0*'
_output_shapes
:         9
a
dense/Tensordot/Const_2Const*
valueB:9*
dtype0*
_output_shapes
:
_
dense/Tensordot/concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
д
dense/Tensordot/concat_1ConcatV2dense/Tensordot/GatherV2dense/Tensordot/Const_2dense/Tensordot/concat_1/axis*
T0*
N*
_output_shapes
:
В
dense/TensordotReshapedense/Tensordot/MatMuldense/Tensordot/concat_1*+
_output_shapes
:         99*
T0
p
dense/BiasAddBiasAdddense/Tensordotdense/bias/read*+
_output_shapes
:         99*
T0
\
	diag_partMatrixDiagPartdense/BiasAdd*
T0*'
_output_shapes
:         9
O
SigmoidSigmoid	diag_part*
T0*'
_output_shapes
:         9

initNoOp

init_all_tablesNoOp

init_1NoOp
4

group_depsNoOp^init^init_1^init_all_tables
Y
save/filename/inputConst*
dtype0*
_output_shapes
: *
valueB Bmodel
n
save/filenamePlaceholderWithDefaultsave/filename/input*
shape: *
dtype0*
_output_shapes
: 
e

save/ConstPlaceholderWithDefaultsave/filename*
shape: *
dtype0*
_output_shapes
: 
Д
save/StringJoin/inputs_1Const*
dtype0*
_output_shapes
: *<
value3B1 B+_temp_e80d376c424c41feb50473838584764e/part
d
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
_output_shapes
: 
Q
save/num_shardsConst*
_output_shapes
: *
value	B :*
dtype0
k
save/ShardedFilename/shardConst"/device:CPU:0*
value	B : *
dtype0*
_output_shapes
: 
М
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
░
save/SaveV2/tensor_namesConst"/device:CPU:0*U
valueLBJBclass_queryB
dense/biasBdense/kernelBglobal_stepBshared_query*
dtype0*
_output_shapes
:
|
save/SaveV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*
valueBB B B B B 
▌
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesclass_query
dense/biasdense/kernelglobal_step/Read/ReadVariableOpshared_query"/device:CPU:0*
dtypes	
2	
а
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: *
T0
а
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
T0*
N*
_output_shapes
:
u
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0
Й
save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
T0*
_output_shapes
: 
│
save/RestoreV2/tensor_namesConst"/device:CPU:0*U
valueLBJBclass_queryB
dense/biasBdense/kernelBglobal_stepBshared_query*
dtype0*
_output_shapes
:

save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
valueBB B B B B *
dtype0*
_output_shapes
:
│
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*(
_output_shapes
:::::*
dtypes	
2	
А
save/AssignAssignclass_querysave/RestoreV2*
T0*
_class
loc:@class_query*#
_output_shapes
:9А
y
save/Assign_1Assign
dense/biassave/RestoreV2:1*
T0*
_class
loc:@dense/bias*
_output_shapes
:9
В
save/Assign_2Assigndense/kernelsave/RestoreV2:2*
T0*
_class
loc:@dense/kernel*
_output_shapes
:	А9
P
save/Identity_1Identitysave/RestoreV2:3*
_output_shapes
:*
T0	
T
save/AssignVariableOpAssignVariableOpglobal_stepsave/Identity_1*
dtype0	
Г
save/Assign_3Assignshared_querysave/RestoreV2:4*
T0*
_class
loc:@shared_query* 
_output_shapes
:
 
p
save/restore_shardNoOp^save/Assign^save/AssignVariableOp^save/Assign_1^save/Assign_2^save/Assign_3
-
save/restore_allNoOp^save/restore_shard"Ж<
save/Const:0save/Identity:0save/restore_all (5 @F8"о
trainable_variablesЦУ
i
shared_query:0shared_query/Assignshared_query/read:02+shared_query/Initializer/truncated_normal:08
e
class_query:0class_query/Assignclass_query/read:02*class_query/Initializer/truncated_normal:08
g
dense/kernel:0dense/kernel/Assigndense/kernel/read:02)dense/kernel/Initializer/random_uniform:08
V
dense/bias:0dense/bias/Assigndense/bias/read:02dense/bias/Initializer/zeros:08"|
global_stepmk
i
global_step:0global_step/Assign!global_step/Read/ReadVariableOp:0(2global_step/Initializer/zeros:0"П
	variablesБ■
i
global_step:0global_step/Assign!global_step/Read/ReadVariableOp:0(2global_step/Initializer/zeros:0
i
shared_query:0shared_query/Assignshared_query/read:02+shared_query/Initializer/truncated_normal:08
e
class_query:0class_query/Assignclass_query/read:02*class_query/Initializer/truncated_normal:08
g
dense/kernel:0dense/kernel/Assigndense/kernel/read:02)dense/kernel/Initializer/random_uniform:08
V
dense/bias:0dense/bias/Assigndense/bias/read:02dense/bias/Initializer/zeros:08"%
saved_model_main_op


group_deps*╒
serving_default┴
?

embeddings1
embeddings:0                  А
:

input_mask,
input_mask:0                  :
	attention-
	Softmax:0         9         7
pooled_output&

MatMul_1:0         9А1
probabilities 
	Sigmoid:0         9tensorflow/serving/predict╧▓
Й┘
:
Add
x"T
y"T
z"T"
Ttype:
2	
B
AssignVariableOp
resource
value"dtype"
dtypetypeИ
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(И
=
Mul
x"T
y"T
z"T"
Ttype:
2	Р

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
~
RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	И
@
ReadVariableOp
resource
value"dtype"
dtypetypeИ
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0И
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0И
H
ShardedFilename
basename	
shard

num_shards
filename
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	
,
TPUOrdinalSelector
device_ordinalsИ
{
TPUPartitionedCall
args2Tin
device_ordinal
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc
А
TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	И
q
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshapeИ
9
VarIsInitializedOp
resource
is_initialized
И"serve"tpu*1.15.02v1.15.0-0-g590d6eef7e8╪Ч

global_step/Initializer/zerosConst*
value	B	 R *
_class
loc:@global_step*
dtype0	*
_output_shapes
: 
К
global_stepVarHandleOp*
shared_nameglobal_step*
_class
loc:@global_step*
dtype0	*
_output_shapes
: *
shape: 
g
,global_step/IsInitialized/VarIsInitializedOpVarIsInitializedOpglobal_step*
_output_shapes
: 
_
global_step/AssignAssignVariableOpglobal_stepglobal_step/Initializer/zeros*
dtype0	
c
global_step/Read/ReadVariableOpReadVariableOpglobal_step*
dtype0	*
_output_shapes
: 
Й

embeddingsPlaceholder**
shape!:                  А*
dtype0*5
_output_shapes#
!:                  А


input_maskPlaceholder*
dtype0*0
_output_shapes
:                  *%
shape:                  
е
/shared_query/Initializer/truncated_normal/shapeConst*!
valueB"          *
_class
loc:@shared_query*
dtype0*
_output_shapes
:
Ф
.shared_query/Initializer/truncated_normal/meanConst*
valueB
 *    *
_class
loc:@shared_query*
dtype0*
_output_shapes
: 
Ц
0shared_query/Initializer/truncated_normal/stddevConst*
valueB
 *
╫г<*
_class
loc:@shared_query*
dtype0*
_output_shapes
: 
╓
9shared_query/Initializer/truncated_normal/TruncatedNormalTruncatedNormal/shared_query/Initializer/truncated_normal/shape*
T0*
_class
loc:@shared_query*
dtype0* 
_output_shapes
:
 
э
-shared_query/Initializer/truncated_normal/mulMul9shared_query/Initializer/truncated_normal/TruncatedNormal0shared_query/Initializer/truncated_normal/stddev*
T0*
_class
loc:@shared_query* 
_output_shapes
:
 
█
)shared_query/Initializer/truncated_normalAdd-shared_query/Initializer/truncated_normal/mul.shared_query/Initializer/truncated_normal/mean*
T0*
_class
loc:@shared_query* 
_output_shapes
:
 
Ч
shared_queryVarHandleOp*
_output_shapes
: *
shape:
 *
shared_nameshared_query*
_class
loc:@shared_query*
dtype0
i
-shared_query/IsInitialized/VarIsInitializedOpVarIsInitializedOpshared_query*
_output_shapes
: 
m
shared_query/AssignAssignVariableOpshared_query)shared_query/Initializer/truncated_normal*
dtype0
o
 shared_query/Read/ReadVariableOpReadVariableOpshared_query*
dtype0* 
_output_shapes
:
 
г
.class_query/Initializer/truncated_normal/shapeConst*
_output_shapes
:*!
valueB"   9      *
_class
loc:@class_query*
dtype0
Т
-class_query/Initializer/truncated_normal/meanConst*
valueB
 *    *
_class
loc:@class_query*
dtype0*
_output_shapes
: 
Ф
/class_query/Initializer/truncated_normal/stddevConst*
valueB
 *
╫г<*
_class
loc:@class_query*
dtype0*
_output_shapes
: 
╓
8class_query/Initializer/truncated_normal/TruncatedNormalTruncatedNormal.class_query/Initializer/truncated_normal/shape*
_class
loc:@class_query*
dtype0*#
_output_shapes
:9А*
T0
ь
,class_query/Initializer/truncated_normal/mulMul8class_query/Initializer/truncated_normal/TruncatedNormal/class_query/Initializer/truncated_normal/stddev*
T0*
_class
loc:@class_query*#
_output_shapes
:9А
┌
(class_query/Initializer/truncated_normalAdd,class_query/Initializer/truncated_normal/mul-class_query/Initializer/truncated_normal/mean*
T0*
_class
loc:@class_query*#
_output_shapes
:9А
Ч
class_queryVarHandleOp*
shape:9А*
shared_nameclass_query*
_class
loc:@class_query*
dtype0*
_output_shapes
: 
g
,class_query/IsInitialized/VarIsInitializedOpVarIsInitializedOpclass_query*
_output_shapes
: 
j
class_query/AssignAssignVariableOpclass_query(class_query/Initializer/truncated_normal*
dtype0
p
class_query/Read/ReadVariableOpReadVariableOpclass_query*
dtype0*#
_output_shapes
:9А
Я
-dense/kernel/Initializer/random_uniform/shapeConst*
valueB"   9   *
_class
loc:@dense/kernel*
dtype0*
_output_shapes
:
С
+dense/kernel/Initializer/random_uniform/minConst*
dtype0*
_output_shapes
: *
valueB
 *nзо╜*
_class
loc:@dense/kernel
С
+dense/kernel/Initializer/random_uniform/maxConst*
valueB
 *nзо=*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
: 
═
5dense/kernel/Initializer/random_uniform/RandomUniformRandomUniform-dense/kernel/Initializer/random_uniform/shape*
T0*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
:	А9
╬
+dense/kernel/Initializer/random_uniform/subSub+dense/kernel/Initializer/random_uniform/max+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc:@dense/kernel*
_output_shapes
: 
с
+dense/kernel/Initializer/random_uniform/mulMul5dense/kernel/Initializer/random_uniform/RandomUniform+dense/kernel/Initializer/random_uniform/sub*
T0*
_class
loc:@dense/kernel*
_output_shapes
:	А9
╙
'dense/kernel/Initializer/random_uniformAdd+dense/kernel/Initializer/random_uniform/mul+dense/kernel/Initializer/random_uniform/min*
_output_shapes
:	А9*
T0*
_class
loc:@dense/kernel
Ц
dense/kernelVarHandleOp*
dtype0*
_output_shapes
: *
shape:	А9*
shared_namedense/kernel*
_class
loc:@dense/kernel
i
-dense/kernel/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense/kernel*
_output_shapes
: 
k
dense/kernel/AssignAssignVariableOpdense/kernel'dense/kernel/Initializer/random_uniform*
dtype0
n
 dense/kernel/Read/ReadVariableOpReadVariableOpdense/kernel*
dtype0*
_output_shapes
:	А9
И
dense/bias/Initializer/zerosConst*
valueB9*    *
_class
loc:@dense/bias*
dtype0*
_output_shapes
:9
Л

dense/biasVarHandleOp*
shared_name
dense/bias*
_class
loc:@dense/bias*
dtype0*
_output_shapes
: *
shape:9
e
+dense/bias/IsInitialized/VarIsInitializedOpVarIsInitializedOp
dense/bias*
_output_shapes
: 
\
dense/bias/AssignAssignVariableOp
dense/biasdense/bias/Initializer/zeros*
dtype0
e
dense/bias/Read/ReadVariableOpReadVariableOp
dense/bias*
dtype0*
_output_shapes
:9
M
TPUOrdinalSelectorTPUOrdinalSelector*#
_output_shapes
:         
Б
TPUPartitionedCallTPUPartitionedCallshared_queryclass_query
embeddings
input_maskdense/kernel
dense/biasTPUOrdinalSelector*
Tout

2*!
fR
tpu_subgraph_Rah5es9G3jI*,
_output_shapes
::::::*
Tin

2

initNoOp

init_all_tablesNoOp

init_1NoOp
4

group_depsNoOp^init^init_1^init_all_tables
Y
save/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
n
save/filenamePlaceholderWithDefaultsave/filename/input*
shape: *
dtype0*
_output_shapes
: 
e

save/ConstPlaceholderWithDefaultsave/filename*
_output_shapes
: *
shape: *
dtype0
Д
save/StringJoin/inputs_1Const*<
value3B1 B+_temp_d1b3d8ec88534a0dacd60cc10a35f4b7/part*
dtype0*
_output_shapes
: 
d
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
_output_shapes
: 
Q
save/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
k
save/ShardedFilename/shardConst"/device:CPU:0*
value	B : *
dtype0*
_output_shapes
: 
М
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
░
save/SaveV2/tensor_namesConst"/device:CPU:0*
dtype0*
_output_shapes
:*U
valueLBJBclass_queryB
dense/biasBdense/kernelBglobal_stepBshared_query
|
save/SaveV2/shape_and_slicesConst"/device:CPU:0*
valueBB B B B B *
dtype0*
_output_shapes
:
н
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesclass_query/Read/ReadVariableOpdense/bias/Read/ReadVariableOp dense/kernel/Read/ReadVariableOpglobal_step/Read/ReadVariableOp shared_query/Read/ReadVariableOp"/device:CPU:0*
dtypes	
2	
а
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
а
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
T0*
N*
_output_shapes
:
u
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0
Й
save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
T0*
_output_shapes
: 
│
save/RestoreV2/tensor_namesConst"/device:CPU:0*U
valueLBJBclass_queryB
dense/biasBdense/kernelBglobal_stepBshared_query*
dtype0*
_output_shapes
:

save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
valueBB B B B B *
dtype0*
_output_shapes
:
│
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*
dtypes	
2	*(
_output_shapes
:::::
N
save/Identity_1Identitysave/RestoreV2*
T0*
_output_shapes
:
T
save/AssignVariableOpAssignVariableOpclass_querysave/Identity_1*
dtype0
P
save/Identity_2Identitysave/RestoreV2:1*
T0*
_output_shapes
:
U
save/AssignVariableOp_1AssignVariableOp
dense/biassave/Identity_2*
dtype0
P
save/Identity_3Identitysave/RestoreV2:2*
T0*
_output_shapes
:
W
save/AssignVariableOp_2AssignVariableOpdense/kernelsave/Identity_3*
dtype0
P
save/Identity_4Identitysave/RestoreV2:3*
T0	*
_output_shapes
:
V
save/AssignVariableOp_3AssignVariableOpglobal_stepsave/Identity_4*
dtype0	
P
save/Identity_5Identitysave/RestoreV2:4*
_output_shapes
:*
T0
W
save/AssignVariableOp_4AssignVariableOpshared_querysave/Identity_5*
dtype0
Ъ
save/restore_shardNoOp^save/AssignVariableOp^save/AssignVariableOp_1^save/AssignVariableOp_2^save/AssignVariableOp_3^save/AssignVariableOp_4
-
save/restore_allNoOp^save/restore_shardЭE
ЪE
 
tpu_subgraph_Rah5es9G3jI*
&broadcastto_readvariableop_placeholder%
!concat_readvariableop_placeholder
matmul_placeholder
sub_placeholder.
*dense_tensordot_readvariableop_placeholder,
(dense_biasadd_readvariableop_placeholder
output_0_shard_0
output_1_shard_0
output_2_shard_0
output_3_shard_0
output_4_shard_0
output_5_shard_0И
cluster/pivotNoOpm
TPUReplicateMetadataTPUReplicateMetadata^cluster/pivot*
num_replicas*
_tpu_replicate	clusterХ
BroadcastTo/ReadVariableOpReadVariableOp&broadcastto_readvariableop_placeholder^TPUReplicateMetadata*
dtype0*
_tpu_replicate	cluster~
BroadcastTo/shapeConst^TPUReplicateMetadata*
_tpu_replicate	cluster*!
valueB"   9       *
dtype0А
BroadcastToBroadcastTo"BroadcastTo/ReadVariableOp:value:0BroadcastTo/shape:output:0*
_tpu_replicate	cluster*
T0Л
concat/ReadVariableOpReadVariableOp!concat_readvariableop_placeholder^TPUReplicateMetadata*
_tpu_replicate	cluster*
dtype0i
concat/axisConst^TPUReplicateMetadata*
value	B :*
dtype0*
_tpu_replicate	clusterМ
concatConcatV2BroadcastTo:output:0concat/ReadVariableOp:value:0concat/axis:output:0*
T0*
N*
_tpu_replicate	clustero
MatMulBatchMatMulV2concat:output:0matmul_placeholder*
adj_y(*
T0*
_tpu_replicate	clusterc
sub/yConst^TPUReplicateMetadata*
dtype0*
_tpu_replicate	cluster*
value	B :Q
subSubsub_placeholdersub/y:output:0*
T0*
_tpu_replicate	cluster9
AbsAbssub:z:0*
_tpu_replicate	cluster*
T0J
CastCastAbs:y:0*

SrcT0*

DstT0*
_tpu_replicate	clusterl
ExpandDims/dimConst^TPUReplicateMetadata*
value	B :*
dtype0*
_tpu_replicate	clustera

ExpandDims
ExpandDimsCast:y:0ExpandDims/dim:output:0*
_tpu_replicate	cluster*
T0f
mul/xConst^TPUReplicateMetadata*
_tpu_replicate	cluster*
valueB
 *(knN*
dtype0U
mulMulmul/x:output:0ExpandDims:output:0*
T0*
_tpu_replicate	clusterL
sub_1SubMatMul:output:0mul:z:0*
T0*
_tpu_replicate	clusterC
SoftmaxSoftmax	sub_1:z:0*
_tpu_replicate	cluster*
T0f
MatMul_1BatchMatMulV2Softmax:softmax:0matmul_placeholder*
T0*
_tpu_replicate	clusterЭ
dense/Tensordot/ReadVariableOpReadVariableOp*dense_tensordot_readvariableop_placeholder^TPUReplicateMetadata*
dtype0*
_tpu_replicate	clusterv
dense/Tensordot/axesConst^TPUReplicateMetadata*
_tpu_replicate	cluster*
valueB:*
dtype0}
dense/Tensordot/freeConst^TPUReplicateMetadata*
valueB"       *
dtype0*
_tpu_replicate	clusterW
dense/Tensordot/ShapeShapeMatMul_1:output:0*
T0*
_tpu_replicate	cluster{
dense/Tensordot/GatherV2/axisConst^TPUReplicateMetadata*
value	B : *
dtype0*
_tpu_replicate	cluster╘
dense/Tensordot/GatherV2GatherV2dense/Tensordot/Shape:output:0dense/Tensordot/free:output:0&dense/Tensordot/GatherV2/axis:output:0*
_tpu_replicate	cluster*
Taxis0*
Tindices0*
Tparams0}
dense/Tensordot/GatherV2_1/axisConst^TPUReplicateMetadata*
value	B : *
dtype0*
_tpu_replicate	cluster╪
dense/Tensordot/GatherV2_1GatherV2dense/Tensordot/Shape:output:0dense/Tensordot/axes:output:0(dense/Tensordot/GatherV2_1/axis:output:0*
Tindices0*
Tparams0*
_tpu_replicate	cluster*
Taxis0w
dense/Tensordot/ConstConst^TPUReplicateMetadata*
_tpu_replicate	cluster*
valueB: *
dtype0Е
dense/Tensordot/ProdProd!dense/Tensordot/GatherV2:output:0dense/Tensordot/Const:output:0*
T0*
_tpu_replicate	clustery
dense/Tensordot/Const_1Const^TPUReplicateMetadata*
valueB: *
dtype0*
_tpu_replicate	clusterЛ
dense/Tensordot/Prod_1Prod#dense/Tensordot/GatherV2_1:output:0 dense/Tensordot/Const_1:output:0*
_tpu_replicate	cluster*
T0y
dense/Tensordot/concat/axisConst^TPUReplicateMetadata*
value	B : *
dtype0*
_tpu_replicate	cluster╡
dense/Tensordot/concatConcatV2dense/Tensordot/free:output:0dense/Tensordot/axes:output:0$dense/Tensordot/concat/axis:output:0*
N*
_tpu_replicate	cluster*
T0М
dense/Tensordot/stackPackdense/Tensordot/Prod:output:0dense/Tensordot/Prod_1:output:0*
T0*
N*
_tpu_replicate	clusterА
dense/Tensordot/transpose	TransposeMatMul_1:output:0dense/Tensordot/concat:output:0*
_tpu_replicate	cluster*
T0З
dense/Tensordot/ReshapeReshapedense/Tensordot/transpose:y:0dense/Tensordot/stack:output:0*
_tpu_replicate	cluster*
T0Й
 dense/Tensordot/transpose_1/permConst^TPUReplicateMetadata*
valueB"       *
dtype0*
_tpu_replicate	clusterб
dense/Tensordot/transpose_1	Transpose&dense/Tensordot/ReadVariableOp:value:0)dense/Tensordot/transpose_1/perm:output:0*
_tpu_replicate	cluster*
T0И
dense/Tensordot/Reshape_1/shapeConst^TPUReplicateMetadata*
valueB"   9   *
dtype0*
_tpu_replicate	clusterХ
dense/Tensordot/Reshape_1Reshapedense/Tensordot/transpose_1:y:0(dense/Tensordot/Reshape_1/shape:output:0*
T0*
_tpu_replicate	clusterМ
dense/Tensordot/MatMulMatMul dense/Tensordot/Reshape:output:0"dense/Tensordot/Reshape_1:output:0*
_tpu_replicate	cluster*
T0y
dense/Tensordot/Const_2Const^TPUReplicateMetadata*
_tpu_replicate	cluster*
valueB:9*
dtype0{
dense/Tensordot/concat_1/axisConst^TPUReplicateMetadata*
value	B : *
dtype0*
_tpu_replicate	cluster└
dense/Tensordot/concat_1ConcatV2!dense/Tensordot/GatherV2:output:0 dense/Tensordot/Const_2:output:0&dense/Tensordot/concat_1/axis:output:0*
T0*
N*
_tpu_replicate	clusterЕ
dense/TensordotReshape dense/Tensordot/MatMul:product:0!dense/Tensordot/concat_1:output:0*
_tpu_replicate	cluster*
T0Щ
dense/BiasAdd/ReadVariableOpReadVariableOp(dense_biasadd_readvariableop_placeholder^TPUReplicateMetadata*
_tpu_replicate	cluster*
dtype0~
dense/BiasAddBiasAdddense/Tensordot:output:0$dense/BiasAdd/ReadVariableOp:value:0*
T0*
_tpu_replicate	clusterY
	diag_partMatrixDiagPartdense/BiasAdd:output:0*
T0*
_tpu_replicate	clusterN
SigmoidSigmoiddiag_part:diagonal:0*
_tpu_replicate	cluster*
T09
NoOpNoOp^cluster/pivot*
_tpu_replicate	clusterИ
IdentityIdentitySoftmax:softmax:0"/device:TPU_REPLICATED_CORE:0*
_tpu_replicate	cluster*
T0*
_tpu_output_identity(К

Identity_1IdentityMatMul_1:output:0"/device:TPU_REPLICATED_CORE:0*
T0*
_tpu_output_identity(*
_tpu_replicate	clusterД

Identity_2IdentitySigmoid:y:0"/device:TPU_REPLICATED_CORE:0*
_tpu_replicate	cluster*
T0*
_tpu_output_identity(Д

Identity_3IdentitySigmoid:y:0"/device:TPU_REPLICATED_CORE:0*
_tpu_replicate	cluster*
T0*
_tpu_output_identity(К

Identity_4IdentitySoftmax:softmax:0"/device:TPU_REPLICATED_CORE:0*
T0*
_tpu_output_identity(*
_tpu_replicate	clusterК

Identity_5IdentityMatMul_1:output:0"/device:TPU_REPLICATED_CORE:0*
T0*
_tpu_output_identity(*
_tpu_replicate	clusteri
TPUCompilationResultTPUCompilationResult^TPUReplicateMetadata*$
_tpu_compilation_status	clusterN
output0TPUReplicatedOutputIdentity:output:0*
T0*
num_replicasA
output_0_shard_0_0Identityoutput0:outputs:0^NoOp*
T0P
output1TPUReplicatedOutputIdentity_1:output:0*
T0*
num_replicasA
output_1_shard_0_0Identityoutput1:outputs:0^NoOp*
T0P
output2TPUReplicatedOutputIdentity_2:output:0*
T0*
num_replicasA
output_2_shard_0_0Identityoutput2:outputs:0^NoOp*
T0P
output3TPUReplicatedOutputIdentity_3:output:0*
T0*
num_replicasA
output_3_shard_0_0Identityoutput3:outputs:0^NoOp*
T0P
output4TPUReplicatedOutputIdentity_4:output:0*
T0*
num_replicasA
output_4_shard_0_0Identityoutput4:outputs:0^NoOp*
T0P
output5TPUReplicatedOutputIdentity_5:output:0*
T0*
num_replicasA
output_5_shard_0_0Identityoutput5:outputs:0^NoOp*
T0"/
output_2_shard_0output_2_shard_0_0:output:0"/
output_3_shard_0output_3_shard_0_0:output:0"/
output_4_shard_0output_4_shard_0_0:output:0"/
output_5_shard_0output_5_shard_0_0:output:0"/
output_0_shard_0output_0_shard_0_0:output:0"/
output_1_shard_0output_1_shard_0_0:output:0*#
_disable_call_shape_inference(:  : : : : : "Ж<
save/Const:0save/Identity:0save/restore_all (5 @F8"Є
trainable_variables┌╫
z
shared_query:0shared_query/Assign"shared_query/Read/ReadVariableOp:0(2+shared_query/Initializer/truncated_normal:08
v
class_query:0class_query/Assign!class_query/Read/ReadVariableOp:0(2*class_query/Initializer/truncated_normal:08
x
dense/kernel:0dense/kernel/Assign"dense/kernel/Read/ReadVariableOp:0(2)dense/kernel/Initializer/random_uniform:08
g
dense/bias:0dense/bias/Assign dense/bias/Read/ReadVariableOp:0(2dense/bias/Initializer/zeros:08"|
global_stepmk
i
global_step:0global_step/Assign!global_step/Read/ReadVariableOp:0(2global_step/Initializer/zeros:0"╙
	variables┼┬
i
global_step:0global_step/Assign!global_step/Read/ReadVariableOp:0(2global_step/Initializer/zeros:0
z
shared_query:0shared_query/Assign"shared_query/Read/ReadVariableOp:0(2+shared_query/Initializer/truncated_normal:08
v
class_query:0class_query/Assign!class_query/Read/ReadVariableOp:0(2*class_query/Initializer/truncated_normal:08
x
dense/kernel:0dense/kernel/Assign"dense/kernel/Read/ReadVariableOp:0(2)dense/kernel/Initializer/random_uniform:08
g
dense/bias:0dense/bias/Assign dense/bias/Read/ReadVariableOp:0(2dense/bias/Initializer/zeros:08"%
saved_model_main_op


group_deps*╢
serving_defaultв
:

input_mask,
input_mask:0                  
?

embeddings1
embeddings:0                  А-
probabilities
TPUPartitionedCall:3)
	attention
TPUPartitionedCall:4-
pooled_output
TPUPartitionedCall:5tensorflow/serving/predict