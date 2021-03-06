
void quantificationOverId() {
    alias A<T> => T;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    String y1 = x1;
    String y2 = x2;
    @error String y3 = x3;
    Anything y4 = x3;
    Invariant<A<in Integer>> iaii = nothing;
    Invariant<Anything> ia = iaii;
    Invariant<A<out Integer>> iaoi = nothing;
    Invariant<Integer> ii = iaoi;
    Invariant<A<out Integer>> iai = nothing;
    Invariant<Integer> ii2 = iai;

    @error alias B<in T> => T;
    B<String> z1 = nothing;
    String w1 = z1;

    alias C<out T> => T;
    C<String> z2 = nothing;
    String w2 = z1;
}

void quantificationOverIdWithSimpleBounds() {
    alias A<T> given T satisfies Object => T;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    String y1 = x1;
    String y2 = x2;
    @error String y3 = x3;
    Object y4 = x3;
    Invariant<A<in Integer>> iaii = nothing;
    Invariant<Object> ia = iaii;
    Invariant<A<out Integer>> iaoi = nothing;
    Invariant<Integer> ii = iaoi;
    Invariant<A<out Integer>> iai = nothing;
    Invariant<Integer> ii2 = iai;
}

void quantificationOverIdWithBounds() {
    alias A<T> given T satisfies Summable<T> => T;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    String y1 = x1;
    String y2 = x2;
    @error String y3 = x3;
    Summable<in String> y4 = x3;
    Invariant<A<in Integer>> iaii = nothing;
    Invariant<Summable<in Integer>> ia = iaii;
    Invariant<A<out Integer>> iaoi = nothing;
    Invariant<Integer> ii = iaoi;
    Invariant<A<out Integer>> iai = nothing;
    Invariant<Integer> ii2 = iai;
}

interface Invariant<T> {}

void quantificationOverInv() {
    alias A<T> => Invariant<T>;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    Invariant<String> y1 = x1;
    @error Invariant<String> y2 = x2;
    @error Invariant<String> y3 = x3;
}

interface Covariant<out T> {}

void quantificationOverCo() {
    alias A<T> => Covariant<T>;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    Covariant<String> y1 = x1;
    Covariant<String> y2 = x2;
    @error Covariant<String> y3 = x3;
    Covariant<Anything> y4 = x3;
}

void quantificationOverCoWithSimpleBounds() {
    alias A<T> given T satisfies Object => Covariant<T>;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    Covariant<String> y1 = x1;
    Covariant<String> y2 = x2;
    @error Covariant<String> y3 = x3;
    Covariant<Object> y4 = x3;
}

void quantificationOverCoWithBounds() {
    alias A<T> given T satisfies Summable<T> => Covariant<T>;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    Covariant<String> y1 = x1;
    Covariant<String> y2 = x2;
    @error Covariant<String> y3 = x3;
    Covariant<Summable<in String>> y4 = x3;
}

void quantificationOverCoWithTrickyBounds() {
    //BLOWS UP THE TYPECHECKER!
    /*alias B<T> given T satisfies {T*} => T;
    B<in String> a = nothing;
    {String*} b = a;*/
    
    alias A<T> 
            given T satisfies Correspondence<Integer,Character> & 
                              {Character*} 
            => Covariant<T|Integer>;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    Covariant<String|Integer> y1 = x1;
    Covariant<String|Integer> y2 = x2;
    @error Covariant<String|Integer> y3 = x3;
    Covariant<Correspondence<Integer,Character>&{Character*}|Integer> y4 = x3;
}

interface Contravariant<in T> {}

void quantificationOverContra() {
    alias A<T> => Contravariant<T>;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    Contravariant<String> y1 = x1;
    @error Contravariant<String> y2 = x2;
    Contravariant<String> y3 = x3;
}

interface OtherInvariant<T> {}

void quantificationOverInvariantAndOtherInvariant() {
    alias A<T> => Invariant<T> & OtherInvariant<T>;
    A<String> x1 = nothing;
    A<out String> x2 = nothing;
    A<in String> x3 = nothing;
    Invariant<String> & OtherInvariant<String> y1 = x1;
    @error Invariant<String> y2 = x2;
    @error Invariant<String> y3 = x3;
    @error OtherInvariant<String> y4 = x2;
    @error OtherInvariant<String> y5 = x3;
    A<String> z1 = y1;
}
