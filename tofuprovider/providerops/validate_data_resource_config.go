package providerops

import (
	"github.com/apparentlymart/opentofu-providers/tofuprovider/internal/common"
	"github.com/apparentlymart/opentofu-providers/tofuprovider/providerschema"
)

type ValidateDataResourceConfigRequest struct {
	// ResourceType is the name of the type of resource the given configuration
	// is intended for.
	ResourceType string

	// Config is a dynamic value representation of the object value
	// representing the resource configuration.
	//
	// A value must be provided and its serialization type must be the implied
	// type of the schema given in by this provider's
	// [providerschema.ProviderSchema.DataResourceTypeSchemas] method.
	Config providerschema.DynamicValueIn
}

type ValidateDataResourceConfigResponse interface {
	// Diagnostics describe any problems the provider reported with the
	// provided configuration.
	//
	// If this includes any error diagnostics then passing the configuration
	// object is somehow invalid and so passing it to other methods causes
	// unspecified behavior.
	Diagnostics() Diagnostics

	common.Sealed
}
