bases=$(notdir $(wildcard bases/*))
basedirs=$(addsuffix /,$(bases))
languages=$(notdir $(wildcard langs/*))
targets=$(foreach base,$(basedirs),$(addprefix $(base),$(languages)))

all: $(targets)
	@wc -w $(targets)

clean:
	rm -rf $(basedirs)

$(basedirs):
	mkdir -p $@

%/.censor: %/censor
	cut -f1 $< > $@

.SECONDEXPANSION:
$(targets): langs/$$(notdir $$@) bases/$$(subst /,,$$(dir $$@)) | $$(dir $$@)
	grep -wFf $(word 2,$^) $< | cut -f 2- > $@
