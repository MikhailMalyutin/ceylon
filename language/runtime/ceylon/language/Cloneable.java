package ceylon.language;

import com.redhat.ceylon.compiler.java.metadata.Annotation;
import com.redhat.ceylon.compiler.java.metadata.Annotations;
import com.redhat.ceylon.compiler.java.metadata.CaseTypes;
import com.redhat.ceylon.compiler.java.metadata.Ceylon;
import com.redhat.ceylon.compiler.java.metadata.TypeParameter;
import com.redhat.ceylon.compiler.java.metadata.TypeParameters;
import com.redhat.ceylon.compiler.java.metadata.Variance;

@Ceylon(major = 3)
@TypeParameters(@TypeParameter(value="Clone", variance=Variance.OUT,
        satisfies="ceylon.language.Cloneable<Clone>"))
@CaseTypes(of = "Clone")
public interface Cloneable<Clone extends Cloneable<? extends Clone>> {
    @Annotations(@Annotation("formal"))
    public Clone getClone();
}
