//Golden Ratio naturally looks nice so I'm using it wherever I can
const smallNumber = 42219911;
const largeNumber = 68313251;
const goldenRatio = largeNumber / smallNumber;

//used to make things look nicely scaled
export default function measurementToGoldenRatio(params){
  const b = params.value / (goldenRatio + 1);
  return { big: params.value - b, small: b };
}
