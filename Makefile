FIRMWARE_DIR := flipperzero-firmware
PLUGIN_DIR := plugin
NFC_PLUGINS_DIR := $(FIRMWARE_DIR)/applications/main/nfc/plugins/supported_cards
TEST_DIR := test

.PHONY: build clean copy-plugin test

build:
	ufbt

copy-plugin:
	cp $(PLUGIN_DIR)/bambu.c $(NFC_PLUGINS_DIR)/
	cp $(PLUGIN_DIR)/bambu_filaments.h $(NFC_PLUGINS_DIR)/
	cp $(PLUGIN_DIR)/bambu_parser.h $(NFC_PLUGINS_DIR)/
	cp $(PLUGIN_DIR)/nfc_supported_card_plugin.h $(NFC_PLUGINS_DIR)/
	@if ! grep -q "bambu_parser" $(FIRMWARE_DIR)/applications/main/nfc/application.fam; then \
		echo "" >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
		echo "App(" >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
		echo "    appid=\"bambu_parser\"," >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
		echo "    apptype=FlipperAppType.PLUGIN," >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
		echo "    entry_point=\"bambu_plugin_ep\"," >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
		echo "    targets=[\"f7\"]," >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
		echo "    requires=[\"nfc\"]," >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
		echo "    sources=[\"plugins/supported_cards/bambu.c\"]," >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
		echo ")" >> $(FIRMWARE_DIR)/applications/main/nfc/application.fam; \
	fi

clean:
	rm -rf $(FIRMWARE_DIR)/build
	rm -rf dist
	rm -f $(NFC_PLUGINS_DIR)/bambu.c
	rm -f $(NFC_PLUGINS_DIR)/bambu_filaments.h
	rm -f $(NFC_PLUGINS_DIR)/bambu_parser.h
	rm -f $(NFC_PLUGINS_DIR)/nfc_supported_card_plugin.h
	rm -f $(TEST_DIR)/test_bambu

test: $(TEST_DIR)/test_bambu
	./$(TEST_DIR)/test_bambu

$(TEST_DIR)/test_bambu: $(TEST_DIR)/test_bambu.c $(PLUGIN_DIR)/bambu_parser.h $(PLUGIN_DIR)/bambu_filaments.h
	gcc -o $@ $< -lm -Wall -Wextra
