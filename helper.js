/*
    x = 1       ETH
    y = 2907    USDC
    P = 2486.8
    w = 2012


    To find:
        price_high = 2998.9
        price_low = 1994.2
*/
const k = 10000;

const calculatePh = (Pl, w) => (Pl * (w + k)) / (k - w);
const left = (x, P, Ph) =>
  (x * (Math.sqrt(P) * Math.sqrt(Ph))) / (Math.sqrt(Ph) - Math.sqrt(P));
const right = (y, P, Pl) => y / (Math.sqrt(P) - Math.sqrt(Pl));
const calculateW = (Pl, Ph) => ((Ph - Pl) * k) / (Pl + Ph);

const solveQuadratic = (a, b, p, y) => {  
    const discriminant = (Math.sqrt(a) * y - Math.sqrt(a) * b * Math.sqrt(p)) ** 2 - 4 * b * (-Math.sqrt(a) * Math.sqrt(p) * y);  
    if (discriminant < 0) throw "no solution";
    const z1 = ((-(Math.sqrt(a) * y - Math.sqrt(a) * b * Math.sqrt(p)) + Math.sqrt(discriminant)) / (2 * b));  
    const z2 = ((-(Math.sqrt(a) * y - Math.sqrt(a) * b * Math.sqrt(p)) - Math.sqrt(discriminant)) / (2 * b));  

    if (z1 <= 0 && z2 <= 0) throw "all solutions negative";
    return z1 > 0 ? z1: z2;
};

x = 1;
y = 2907.47;
price = 2486.8;
w = 1;
price_high = 2998.9;
price_low = 1994.2;

a = (w + k) / (k - w);
b = x*Math.sqrt(price);

quad = solveQuadratic(a, b, price, y);
Ph = quad**2;
Pl = Ph / a;

console.log("Pl:", Pl);
console.log("Ph:", Ph);

// Pl = calculatePl(w, x, price, y);
// console.log("priceLow: ", Pl);

// Ph = calculatePh(1994.2, w);
// console.log("priceHigh: ", Ph);

// console.log(left(x, price, price_high));
// console.log(right(y, price, price_low));
// console.log("w:", calculateW(price_low, price_high));
