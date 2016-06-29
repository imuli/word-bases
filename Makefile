bases=256 4096
basedirs=$(addsuffix /,$(bases))
languages=english
targets=$(foreach base,$(basedirs),$(addprefix $(base),$(languages)))

all: $(targets)
	@wc -w $(targets)

clean:
	rm -rf $(basedirs) */.censor

$(basedirs):
	mkdir -p $@

%/.censor: %/censor
	cut -f1 $< > $@

.SECONDEXPANSION:
$(targets): $$(notdir $$@)/words $$(notdir $$@)/.censor | $$(dir $$@)
	grep -vwFf $(word 2,$^) $< | head -n $(subst /,,$(dir $@)) | cut -f1 | sort > $@
